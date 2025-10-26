// --- FUCKIT.SH Cloudflare Worker ---

// This is the content of your main.sh installer script.
// It will be served when a user makes a GET request.
const INSTALLER_SCRIPT = `#!/bin/bash
#
# This script is the installer and temporary runner for fuckit.sh
#
# --- RECOMMENDED SECURE USAGE ---
#
# 1. Download:
#    curl -o fuckit.sh https://fuckit.sh
#
# 2. Inspect:
#    less fuckit.sh
#
# 3. Run (Install):
#    bash fuckit.sh
#
# 4. Run (Temporary):
#    bash fuckit.sh "your prompt"
#

set -euo pipefail

# --- Color Definitions ---
readonly C_RESET='\\033[0m'
readonly C_RED_BOLD='\\033[1;31m'
readonly C_RED='\\033[0;31m'
readonly C_GREEN='\\033[0;32m'
readonly C_YELLOW='\\033[0;33m'
readonly C_CYAN='\\033[0;36m'
readonly C_BOLD='\\033[1m'

# --- FUCK! ---
readonly FUCK="\${C_RED_BOLD}FUCK!\${C_RESET}"
readonly FCKN="\${C_RED}F*CKING\${C_RESET}"


# --- Configuration ---
readonly INSTALL_DIR="$HOME/.fuck"
readonly MAIN_SH="$INSTALL_DIR/main.sh"
# The API endpoint for the Cloudflare Edge Function
readonly API_ENDPOINT="https://fuckit.sh/"


# --- Core Logic (Embedded as a string) ---
CORE_LOGIC=$(cat <<'EOF'

# --- Begin Core Logic for fuckit.sh ---

# --- Color Definitions ---
readonly C_RESET='\\033[0m'
readonly C_RED_BOLD='\\033[1;31m'
readonly C_RED='\\033[0;31m'
readonly C_GREEN='\\033[0;32m'
readonly C_YELLOW='\\033[0;33m'
readonly C_CYAN='\\033[0;36m'
readonly C_BOLD='\\033[1m'

# --- FUCK! ---
readonly FUCK="\${C_RED_BOLD}FUCK!\${C_RESET}"
readonly FCKN="\${C_RED}F*CKING\${C_RESET}"

# --- Configuration ---
readonly INSTALL_DIR="$HOME/.fuck"
readonly MAIN_SH="$INSTALL_DIR/main.sh"

# Helper to find the user's shell profile file
_installer_detect_profile() {
    if [ -n "\${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "\${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        # Fallback for sh, ksh, etc.
        echo "$HOME/.profile"
    elif [ -f "$HOME/.zshrc" ]; then
        # Fallback if SHELL var isn't set
        echo "$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        # Fallback if SHELL var isn't set
        echo "$HOME/.bashrc"
    else
        echo "unknown_profile"
    fi
}

# Detects the package manager
_fuck_detect_pkg_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo "unknown"
    fi
}

# Collects system info as a simple string
_fuck_collect_sysinfo_string() {
    local pkg_manager
    pkg_manager=$(_fuck_detect_pkg_manager)
    # The server-side LLM prompt will need to parse this string
    echo "OS: $(uname -s), Arch: $(uname -m), Shell: \${SHELL:-unknown}, PkgMgr: $pkg_manager, CWD: $(pwd)"
}

# Escapes a string for use in a JSON payload
_fuck_json_escape() {
    # Basic escape for quotes, backslashes, and control characters
    printf '%s' "$1" | sed -e 's/\\\\/\\\\\\\\/g' -e 's/"/\\\\"/g' -e 's/\\n/\\\\n/g' -e 's/\\r/\\\\r/g' -e 's/\\t/\\\\t/g'
}

# Uninstalls the script
_uninstall_script() {
    echo -e "\${C_YELLOW}Uninstalling fuckit.sh...\${C_RESET}"

    # Find the profile file
    local profile_file
    profile_file=$(_installer_detect_profile)
    local source_line="source $MAIN_SH"

    if [ "$profile_file" != "unknown_profile" ] && [ -f "$profile_file" ]; then
        if grep -qF "$source_line" "$profile_file"; then
            echo -e "\${C_CYAN}Removing source line from $profile_file...\${C_RESET}"
            # Use sed to remove the lines. Create a backup.
            sed -i.bak "\\|$source_line|d" "$profile_file"
            sed -i.bak "\\|# Added by fuckit.sh installer|d" "$profile_file"
            echo -e "\${C_GREEN}Source line removed.\${C_RESET}"
        else
            echo -e "\${C_YELLOW}Source line not found in $profile_file. Skipping.\${C_RESET}"
        fi
    else
        echo -e "\${C_YELLOW}Could not find a shell profile file to modify.\${C_RESET}"
    fi

    if [ -d "$INSTALL_DIR" ]; then
        echo -e "\${C_CYAN}Removing installation directory: $INSTALL_DIR...\${C_RESET}"
        rm -rf "$INSTALL_DIR"
        echo -e "\${C_GREEN}Installation directory removed.\${C_RESET}"
    else
        echo -e "\${C_YELLOW}Installation directory not found. Skipping.\${C_RESET}"
    fi

    echo -e "\${C_GREEN}Uninstallation complete.\${C_RESET}"
    echo -e "\${C_CYAN}Please restart your shell for the changes to take effect.\${C_RESET}"
}

# The main function that contacts the API
# Takes >0 arguments as the prompt
_fuck_execute_prompt() {
    if [ "$1" = "uninstall" ]; then
        _uninstall_script
        return 0
    fi

    if ! command -v curl &> /dev/null; then
        echo -e "$FUCK \${C_RED}'fuck' command needs 'curl'. Please install it.\${C_RESET}" >&2
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        echo -e "$FUCK \${C_RED}You forgot to ask me what to do.\${C_RESET}" >&2
        return 1
    fi

    local prompt="$*"
    local sysinfo_string
    sysinfo_string=$(_fuck_collect_sysinfo_string)
    
    local escaped_prompt
    escaped_prompt=$(_fuck_json_escape "$prompt")
    
    local escaped_sysinfo
    escaped_sysinfo=$(_fuck_json_escape "$sysinfo_string")

    # Construct the JSON payload
    local payload
    payload=$(printf '{ "sysinfo": "%s", "prompt": "%s" }' "$escaped_sysinfo" "$escaped_prompt")

    # API_ENDPOINT must be hardcoded here for the logic to be portable
    local api_url="https://fuckit.sh/"

    echo -e "$FCKN \${C_CYAN}thinking...\${C_RESET}" >&2

    local response
    response=$(curl -s -X POST "$api_url" \\
        -H "Content-Type: application/json" \\
        -d "$payload")

    if [ -z "$response" ]; then
        echo -e "$FUCK \${C_RED}The AI is ghosting me. Got nothing back.\${C_RESET}" >&2
        return 1
    fi

    # --- User Confirmation (as requested) ---
    echo -e "\${C_YELLOW}--- The AI mumbled this, hope it's right ---\${C_RESET}"
    # Pipe to 'more' for user review
    echo -e "\${C_CYAN}$response\${C_RESET}" | more
    echo -e "\${C_BOLD}------------------------------------------\${C_RESET}"
    
    # Secondary confirmation prompt
    printf "\${C_YELLOW}$FCKN execute it? [y/N]\${C_RESET} "
    local confirmation
    read -r confirmation

    if [[ "$confirmation" =~ ^[yY]([eE][sS])?$ ]]; then
        echo -e "$FUCK \${C_RED}IT, WE DO IT LIVE!\${C_RESET}" >&2
        # Execute the response from the server
        eval "$response"
        echo -e "\${C_GREEN}$FUCK It's done. Probably.\${C_RESET}"
    else
        echo -e "$FUCK \${C_RED}Fine, do it yourself.\${C_RESET}" >&2
    fi
}

# Define the alias for interactive use
alias fuck='_fuck_execute_prompt'

# --- End Core Logic ---
EOF
)
# --- End of Core Logic Heredoc ---


# --- Installer Functions (Run by the outer script) ---

# Helper to find the user's shell profile file
_installer_detect_profile() {
    if [ -n "\${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "\${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        # Fallback for sh, ksh, etc.
        echo "$HOME/.profile"
    elif [ -f "$HOME/.zshrc" ]; then
        # Fallback if SHELL var isn't set
        echo "$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        # Fallback if SHELL var isn't set
        echo "$HOME/.bashrc"
    else
        echo "unknown_profile"
    fi
}

# Main installation function
_install_script() {
    echo -e "\${C_BOLD}Alright, let's install this shit to $INSTALL_DIR...\${C_RESET}"
    mkdir -p "$INSTALL_DIR"
    
    # Write the embedded core logic to the main.sh file
    echo "$CORE_LOGIC" > "$MAIN_SH"
    
    if [ $? -ne 0 ]; then
        echo -e "$FUCK \${C_RED}Can't write to the file. Check your damn permissions.\${C_RESET}" >&2
        return 1
    fi
    
    echo -e "--- $FUCK \${C_GREEN}It's installed. ---\${C_RESET}"

    # Add source line to shell profile
    local profile_file
    profile_file=$(_installer_detect_profile)
    
    if [ "$profile_file" = "unknown_profile" ]; then
        echo -e "$FUCK \${C_RED}I can't find .bashrc, .zshrc, or .profile. You're on your own.\${C_RESET}" >&2
        echo -e "\${C_YELLOW}Manually add this line to whatever startup file you use:\${C_RESET}" >&2
        echo -e "\\n  \${C_CYAN}source $MAIN_SH\${C_RESET}\\n" >&2
        return
    fi
    
    local source_line="source $MAIN_SH"
    if ! grep -qF "$source_line" "$profile_file"; then
        echo -e "\${C_CYAN}Adding source line to $profile_file...\${C_RESET}"
        echo "" >> "$profile_file"
        echo "# Added by fuckit.sh installer" >> "$profile_file"
        echo "$source_line" >> "$profile_file"
        echo -e "\${C_GREEN}Done. Now restart your goddamn shell or run:\${C_RESET}"
        echo -e "  \${C_CYAN}source $profile_file\${C_RESET}"
    else
        echo -e "\${C_GREEN}Already installed (source line found in $profile_file).\${C_RESET}"
        echo -e "\${C_CYAN}Run 'bash $0' again to update (assuming you saved this as a file).\${C_RESET}"
    fi
}


# --- Main Script Entrypoint ---

# If arguments are passed (e.g., "bash -s ...")
if [ "$#" -gt 0 ]; then
    # Temporary Mode
    echo -e "--- $FCKN \${C_CYAN}in temporary (one-shot) mode... ---\${C_RESET}"
    # Evaluate the core logic to define functions in this shell
    eval "$CORE_LOGIC"
    # Call the main function directly (alias won't work here)
    _fuck_execute_prompt "$@"
else
    # Install Mode
    _install_script
fi
`;

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
 * Handles GET requests to serve the installer script.
 * @param {Request} request The incoming request.
 * @returns {Response} A response with the shell script.
 */
function handleGetRequest(request) {
  return new Response(INSTALLER_SCRIPT, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Content-Disposition': 'attachment; filename="fuckit.sh"',
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
