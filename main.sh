#!/bin/bash
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
readonly C_RESET='\033[0m'
readonly C_RED_BOLD='\033[1;31m'
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_YELLOW='\033[0;33m'
readonly C_CYAN='\033[0;36m'
readonly C_BOLD='\033[1m'

# --- FUCK! ---
readonly FUCK="${C_RED_BOLD}FUCK!${C_RESET}"
readonly FCKN="${C_RED}F*CKING${C_RESET}"


# --- Configuration ---
if [ -z "${HOME:-}" ]; then
    echo -e "\033[1;31mFUCK!\033[0m \033[0;31mYour HOME variable isn't set. I don't know where to install this shit. Set it yourself (e.g., export HOME=/root).\033[0m" >&2
    exit 1
fi
readonly INSTALL_DIR="$HOME/.fuck"
readonly MAIN_SH="$INSTALL_DIR/main.sh"
# The API endpoint for the Cloudflare Edge Function
readonly API_ENDPOINT="https://fuckit.sh/"


# --- Core Logic (Embedded as a string) ---
CORE_LOGIC=$(cat <<'EOF'

# --- Begin Core Logic for fuckit.sh ---

# --- Color Definitions ---
# Only define colors if they haven't been defined yet (for temp mode)
if [ -z "${C_RESET:-}" ]; then
    readonly C_RESET='\033[0m'
    readonly C_RED_BOLD='\033[1;31m'
    readonly C_RED='\033[0;31m'
    readonly C_GREEN='\033[0;32m'
    readonly C_YELLOW='\033[0;33m'
    readonly C_CYAN='\033[0;36m'
    readonly C_BOLD='\033[1m'

    # --- FUCK! ---
    readonly FUCK="${C_RED_BOLD}FUCK!${C_RESET}"
    readonly FCKN="${C_RED}F*CKING${C_RESET}"

    # --- Configuration ---
    if [ -z "${HOME:-}" ]; then
        # This part is for the temporary runner, which doesn't install,
        # but we need the variables defined to avoid unbound errors.
        # The install check will happen in the installer part of the script.
        readonly INSTALL_DIR="/tmp/.fuck"
        readonly MAIN_SH="/tmp/.fuck/main.sh"
    else
        readonly INSTALL_DIR="$HOME/.fuck"
        readonly MAIN_SH="$INSTALL_DIR/main.sh"
    fi
fi

# Helper to find the user's shell profile file
_installer_detect_profile() {
    if [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
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
    echo "OS: $(uname -s), Arch: $(uname -m), Shell: ${SHELL:-unknown}, PkgMgr: $pkg_manager, CWD: $(pwd)"
}

# Escapes a string for use in a JSON payload
_fuck_json_escape() {
    # Basic escape for quotes, backslashes, and control characters
    printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g'
}

# Uninstalls the script
_uninstall_script() {
    echo -e "$FUCK ${C_YELLOW}So you're kicking me out? Fine.${C_RESET}"

    # Find the profile file
    local profile_file
    profile_file=$(_installer_detect_profile)
    local source_line="source $MAIN_SH"

    if [ "$profile_file" != "unknown_profile" ] && [ -f "$profile_file" ]; then
        if grep -qF "$source_line" "$profile_file"; then
            # Use sed to remove the lines. Create a backup.
            sed -i.bak "\|$source_line|d" "$profile_file"
            sed -i.bak "\|# Added by fuckit.sh installer|d" "$profile_file"
        fi
    else
        echo -e "${C_YELLOW}Could not find a shell profile file to modify. Your problem now.${C_RESET}"
    fi

    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
    fi

    echo -e "$FUCK ${C_GREEN}I'm gone. Don't come crying back.${C_RESET}"
    echo -e "${C_CYAN}Now restart your damn shell.${C_RESET}"
}

# The main function that contacts the API
# Takes >0 arguments as the prompt
_fuck_execute_prompt() {
    # If the user types *only* "fuck uninstall"
    if [ "$1" = "uninstall" ] && [ "$#" -eq 1 ]; then
        _uninstall_script
        return 0
    fi

    if ! command -v curl &> /dev/null; then
        echo -e "$FUCK ${C_RED}'fuck' command needs 'curl'. Please install it.${C_RESET}" >&2
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        echo -e "$FUCK ${C_RED}You forgot to ask me what to do.${C_RESET}" >&2
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

    local response
    response=$(curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -d "$payload")

    if [ -z "$response" ]; then
        echo -e "$FUCK ${C_RED}The AI is ghosting me. Got nothing back.${C_RESET}" >&2
        return 1
    fi

    # --- User Confirmation (as requested) ---
    echo -e "${C_YELLOW}--- The AI mumbled this, hope it's right ---${C_RESET}"
    # Direct output, no 'more'
    echo -e "${C_CYAN}$response${C_RESET}"
    echo -e "${C_YELLOW}------------------------------------------${C_RESET}"
    
    # Secondary confirmation prompt
    printf "$FCKN ${C_BOLD}${C_YELLOW}execute it? [y/N]${C_RESET} "
    local confirmation
    read -r confirmation

    if [[ "$confirmation" =~ ^[yY]([eE][sS])?$ ]]; then
        echo -e "$FUCK ${C_RED_BOLD}IT,${C_CYAN} WE DO IT LIVE!${C_RESET}" >&2
        # Execute the response from the server
        eval "$response"
        echo -e "$FUCK ${C_GREEN}It's done. Probably.${C_RESET}"
    else
        echo -e "$FUCK ${C_RED}Fine, do it yourself.${C_RESET}" >&2
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
    if [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
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
    echo -e "$FCKN ${C_BOLD}Alright, let's get this shit installed...${C_RESET}"
    mkdir -p "$INSTALL_DIR"
    
    # Write the embedded core logic to the main.sh file
    echo "$CORE_LOGIC" > "$MAIN_SH"
    
    if [ $? -ne 0 ]; then
        echo -e "$FUCK ${C_RED}Can't write to the file. Check your damn permissions.${C_RESET}" >&2
        return 1
    fi

    # Add source line to shell profile
    local profile_file
    profile_file=$(_installer_detect_profile)
    
    if [ "$profile_file" = "unknown_profile" ]; then
        echo -e "$FUCK ${C_RED}I can't find .bashrc, .zshrc, or .profile. You're on your own.${C_RESET}" >&2
        echo -e "${C_YELLOW}Manually add this line to whatever startup file you use:${C_RESET}" >&2
        echo -e "\n  ${C_CYAN}source $MAIN_SH${C_RESET}\n" >&2
        return
    fi
    
    local source_line="source $MAIN_SH"
    if ! grep -qF "$source_line" "$profile_file"; then
        # Ensure the file ends with a newline before we add our lines
        if [ -n "$(tail -c1 "$profile_file")" ]; then
            echo "" >> "$profile_file"
        fi
        echo "# Added by fuckit.sh installer" >> "$profile_file"
        echo "$source_line" >> "$profile_file"
        echo -e "$FUCK ${C_GREEN}It's installed. Now get to work.${C_RESET}"
        echo -e "${C_YELLOW}Restart your shell, or run ${C_BOLD}source $profile_file${C_YELLOW} to start.${C_RESET}"
        echo -e "\n${C_BOLD}--- HOW TO USE ---${C_RESET}"
        echo -e "Just type ${C_RED_BOLD}fuck${C_RESET} followed by what you want to do."
        echo -e "Examples:"
        echo -e "  ${C_CYAN}fuck install git${C_RESET}"
        echo -e "  ${C_CYAN}fuck uninstall git${C_RESET}"
        echo -e "  ${C_CYAN}fuck find all files larger than 10MB in the current directory${C_RESET}"
        echo -e "  ${C_RED_BOLD}fuck uninstall${C_RESET} ${C_GREEN}# Uninstalls ${C_RESET}${C_RED}fuck${C_RESET}${C_GREEN} itself${C_RESET}"
        echo -e "\n${C_YELLOW}Remember to restart your shell to begin!${C_RESET}"
    else
        echo -e "$FUCK ${C_YELLOW}It's already installed, genius. Just updated the script for you.${C_RESET}"
    fi
}


# --- Main Script Entrypoint ---

# If arguments are passed (e.g., "bash -s ...")
if [ "$#" -gt 0 ]; then
    # Temporary Mode
    # Evaluate the core logic to define functions in this shell
    eval "$CORE_LOGIC"
    # Call the main function directly (alias won't work here)
    _fuck_execute_prompt "$@"
else
    # Install Mode
    _install_script
fi
