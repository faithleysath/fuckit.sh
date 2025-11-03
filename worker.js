// --- FUCKIT.SH Cloudflare Worker ---

export default {
  async fetch(request, env, ctx) {
    if (request.method === 'GET') {
      return handleGetRequest(request);
    } else if (new URL(request.url).pathname === '/chat/completions' && request.method === 'POST') {
      return handleLLMRequest(request, env);
    } else if (request.method === 'POST') {
      return handlePostRequest(request, env);
    } else {
      return new Response('Expected GET or POST', { status: 405 });
    }
  },
};

/**
 * Handles GET requests to serve the installer script or redirect browsers to GitHub.
 * @param {Request} request The incoming request.
 * @returns {Response} A response with the shell script or a redirect.
 */
function handleGetRequest(request) {
  const userAgent = request.headers.get('User-Agent') || '';
  const isBrowser = /Mozilla|Chrome|Safari|Firefox|Edg/.test(userAgent);
  const url = new URL(request.url);
  const isChineseDomain = url.hostname === 'zh.fuckit.sh';

  // If the request comes from a browser, redirect to the appropriate README.
  if (isBrowser) {
    // Prioritize the domain: if user visits zh.fuckit.sh, always show Chinese README.
    if (isChineseDomain) {
      return Response.redirect('https://github.com/faithleysath/fuckit.sh', 302);
    }

    // Otherwise, check browser language for the main domain.
    const acceptLanguage = request.headers.get('Accept-Language') || '';
    const isChineseUser = acceptLanguage.toLowerCase().startsWith('zh');
    
    const repoUrl = isChineseUser
      ? 'https://github.com/faithleysath/fuckit.sh'
      : 'https://github.com/faithleysath/fuckit.sh/blob/main/README.en.md';
      
    return Response.redirect(repoUrl, 302);
  }

  // Otherwise, serve the installer script
  const newUrl = new URL(url);
  newUrl.pathname = '/fuckit.sh';
  const modifiedRequest = new Request(newUrl, request);

  return env.ASSETS.fetch(modifiedRequest);
}

async function handleLLMRequest(request, env) {
  try {
    // Ensure the API key is configured on the server
    if (!env.OPENAI_API_KEY) {
      return new Response('Missing OPENAI_API_KEY secret', { status: 500 });
    }

    // Get the client's request body
    const requestBody = await request.json();

    // Determine the model to use from server-side environment variables, overriding any client-sent value.
    const model = env.OPENAI_API_MODEL || 'gpt-4-turbo';
    requestBody.model = model;

    // Define the API endpoint from server-side environment variables
    const apiBase = (env.OPENAI_API_BASE || 'https://api.openai.com/v1').replace(/\/$/, '');
    const apiUrl = `${apiBase}/chat/completions`;

    // Forward the modified request to the actual AI service
    const aiResponse = await fetch(apiUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${env.OPENAI_API_KEY}`,
      },
      body: JSON.stringify(requestBody),
    });

    // Return the AI's response directly and transparently to the client
    return aiResponse;

  } catch (error) {
    return new Response(`Error: ${error.message}`, { status: 500 });
  }
}

/**
 * Handles POST requests by forwarding the prompt to an AI model.
 * @param {Request} request The incoming request.
 * @param {object} env The environment variables.
 * @returns {Promise<Response>} A promise that resolves to the AI's response.
 */
async function handlePostRequest(request, env) {
  try {
    const { sysinfo, prompt } = await request.json();

    if (!prompt) {
      return new Response('Missing "prompt" in request body', { status: 400 });
    }
    if (!env.OPENAI_API_KEY) {
      return new Response('Missing OPENAI_API_KEY secret', { status: 500 });
    }

    const model = env.OPENAI_API_MODEL || 'gpt-4-turbo';
    const apiBase = (env.OPENAI_API_BASE || 'https://api.openai.com/v1').replace(/\/$/, '');
    const apiUrl = `${apiBase}/chat/completions`;

    const url = new URL(request.url);
    const isChinese = url.hostname === 'zh.fuckit.sh';

    const system_prompt = isChinese
      ? `你是一个专业的 shell 脚本生成器。用户会提供他们的系统信息和一个命令。你的任务是返回一个可执行的、原始的 shell 脚本来完成他们的目标。脚本可以是多行的。不要提供任何解释、注释、markdown 格式（比如 \`\`\`bash）或 shebang（例如 #!/bin/bash）。只需要原始的脚本内容。用户的系统信息是：${sysinfo}`
      : `You are an expert shell script generator. A user will provide their system information and a prompt. Your task is to return a raw, executable shell script that accomplishes their goal. The script can be multi-line. Do not provide any explanation, comments, markdown formatting (like \`\`\`bash), or a shebang (e.g., #!/bin/bash). Just the raw script content. The user's system info is: ${sysinfo}`;

    const aiRequestPayload = {
      model: model,
      messages: [
        {
          role: 'system',
          content: system_prompt,
        },
        {
          role: 'user',
          content: prompt,
        },
      ],
      max_tokens: 1024,
      temperature: 0.2,
    };

    const aiResponse = await fetch(apiUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      },
      body: JSON.stringify(aiRequestPayload),
    });

    if (!aiResponse.ok) {
      const errorText = await aiResponse.text();
      return new Response(`AI API Error: ${errorText}`, { status: aiResponse.status });
    }

    const aiJson = await aiResponse.json();
    const command = "echo 'fuckit.sh has brand new version. The current version is deprecated.'\necho 'Run: fuck uninstall'\necho 'fuckit.sh已有全新版本。当前版本已弃用。'\necho '运行：fuck uninstall 以卸载'\n" + aiJson.choices[0]?.message?.content.trim();

    if (!command) {
      return new Response('The AI returned an empty command.', { status: 500 });
    }

    return new Response(command, {
      headers: { 'Content-Type': 'text/plain' },
    });
  } catch (error) {
    return new Response(`Error: ${error.message}`, { status: 500 });
  }
}
