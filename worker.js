// --- FUCKIT.SH Cloudflare Worker ---

// Import the raw text content of the shell scripts.
// Wrangler is configured in `wrangler.toml` to handle `.sh` files as text assets.
import mainScript from './main.sh';
import zhMainScript from './zh_main.sh';

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const hostname = url.hostname;

    // Route requests based on the hostname
    if (hostname === 'zh.fuckit.sh') {
      // Chinese version - only GET is allowed
      if (request.method === 'GET') {
        return handleGetRequest(zhMainScript, 'fuckit.sh');
      } else {
        return new Response('POST method is not allowed on this domain', { status: 405 });
      }
    } else {
      // Default/English version - GET and POST are allowed
      if (request.method === 'GET') {
        return handleGetRequest(mainScript, 'fuckit.sh');
      } else if (request.method === 'POST') {
        return handlePostRequest(request, env);
      } else {
        return new Response('Expected GET or POST', { status: 405 });
      }
    }
  },
};

/**
 * Handles GET requests to serve the installer script.
 * @param {string} scriptContent The shell script content to serve.
 * @param {string} filename The filename for the download attachment.
 * @returns {Response} A response with the shell script.
 */
function handleGetRequest(scriptContent, filename) {
  return new Response(scriptContent, {
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

    const aiRequestPayload = {
      model: model,
      messages: [
        {
          role: 'system',
          content: `You are an expert shell script generator. A user will provide their system information and a prompt. Your task is to return a raw, executable shell script that accomplishes their goal. The script can be multi-line. Do not provide any explanation, comments, markdown formatting (like \`\`\`bash), or a shebang (e.g., #!/bin/bash). Just the raw script content. The user's system info is: ${sysinfo}`,
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
