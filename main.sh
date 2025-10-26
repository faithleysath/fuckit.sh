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

# --- Configuration ---
readonly INSTALL_DIR="$HOME/.fuck"
readonly MAIN_SH="$INSTALL_DIR/main.sh"
# The API endpoint for the Cloudflare Edge Function
readonly API_ENDPOINT="https://fuckit.sh/"


# --- Core Logic (Embedded as a string) ---
read -r -d '' CORE_LOGIC << 'EOF'

# --- Begin Core Logic for fuckit.sh ---

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

# The main function that contacts the API
# Takes >0 arguments as the prompt
_fuck_execute_prompt() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: fuck \"your natural language prompt\"" >&2
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

    echo "Querying LLM (via $api_url)..." >&2

    local response
    response=$(curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -d "$payload")

    if [ -z "$response" ]; then
        echo "Error: Received empty response from server." >&2
        return 1
    fi

    # --- User Confirmation (as requested) ---
    echo "--- Suggested Command(s) from LLM ---"
    # Pipe to 'more' for user review
    echo "$response" | more
    echo "-------------------------------------"
    
    # Secondary confirmation prompt
    printf "Execute the command(s) above? [y/N] "
    local confirmation
    read -r confirmation

    if [[ "$confirmation" =~ ^[yY]([eE][sS])?$ ]]; then
        echo "Executing..." >&2
        # Execute the response from the server
        eval "$response"
    else
        echo "Aborted." >&2
    fi
}

# Define the alias for interactive use
alias fuck='_fuck_execute_prompt'

# --- End Core Logic ---
EOF
# --- End of Core Logic Heredoc ---


# --- Installer Functions (Run by the outer script) ---

# Helper to find the profile file for the *installer*
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
    echo "Installing fuckit.sh to $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    
    # Write the embedded core logic to the main.sh file
    echo "$CORE_LOGIC" > "$MAIN_SH"
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to write to $MAIN_SH. Check permissions." >&2
        return 1
    fi
    
    echo "Installation successful: $MAIN_SH created."

    # Add source line to shell profile
    local profile_file
    profile_file=$(_installer_detect_profile)
    
    if [ "$profile_file" = "unknown_profile" ]; then
        echo "Warning: Could not detect shell profile." >&2
        echo "Please manually add the following line to your shell's startup file (e.g., .zshrc, .bashrc):" >&2
        echo "" >&2
        echo "  source $MAIN_SH" >&2
        echo "" >&2
        return
    fi
    
    local source_line="source $MAIN_SH"
    if ! grep -qF "$source_line" "$profile_file"; then
        echo "Adding source line to $profile_file..."
        echo "" >> "$profile_file"
        echo "# Added by fuckit.sh installer" >> "$profile_file"
        echo "$source_line" >> "$profile_file"
        echo "Done. Please restart your shell or run:"
        echo "  source $profile_file"
    else
        echo "Already installed (source line found in $profile_file)."
        echo "Run 'bash $0' again to update (assuming you saved this as a file)."
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