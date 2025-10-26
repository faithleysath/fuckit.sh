// --- FUCKIT.SH Cloudflare Worker ---

// This is the content of your main.sh installer script.
// It will be served when a user makes a GET request.
function b64_to_utf8(str) {
  try {
    // This is a more robust way to decode base64 to UTF-8
    const binaryString = atob(str);
    const len = binaryString.length;
    const bytes = new Uint8Array(len);
    for (let i = 0; i < len; i++) {
      bytes[i] = binaryString.charCodeAt(i);
    }
    return new TextDecoder().decode(bytes);
  } catch (e) {
    console.error("Failed to decode base64 string:", e);
    return ""; // Return empty string on failure
  }
}

const INSTALLER_SCRIPT = b64_to_utf8(``);
const INSTALLER_SCRIPT_ZH = b64_to_utf8(``);

export default {
  async fetch(request, env, ctx) {
    if (request.method === 'GET') {
      return handleGetRequest(request);
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

  // Otherwise, serve the installer script based on the domain.
  const script = isChineseDomain ? INSTALLER_SCRIPT_ZH : INSTALLER_SCRIPT;
  const filename = 'fuckit.sh'; // Keep filename consistent

  return new Response(script, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Content-Disposition': `attachment; filename="${filename}"`,
    },
  });
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
    const command = aiJson.choices[0]?.message?.content.trim();

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
