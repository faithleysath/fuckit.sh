#!/bin/bash
#
# 这破逼玩意儿是 fuckit.sh 的安装和临时运行脚本
# 爱用不用，不用滚蛋
#
# --- 安全使用方法（安你妈的全） ---
#
# 1. 下载:
#    curl -o fuckit.sh https://fuckit.sh
#
# 2. 瞅一眼:
#    less fuckit.sh
#
# 3. 运行 (安装):
#    bash fuckit.sh
#
# 4. 运行 (临时用用):
#    bash fuckit.sh "你的弱智命令"
#

set -euo pipefail

# --- 颜色定义 ---
readonly C_RESET='\033[0m'
readonly C_RED_BOLD='\033[1;31m'
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_YELLOW='\033[0;33m'
readonly C_CYAN='\033[0;36m'
readonly C_BOLD='\033[1m'

# --- 操! ---
readonly FUCK="${C_RED_BOLD}操你妈!${C_RESET}"
readonly FCKN="${C_RED}你他妈${C_RESET}"


# --- 配置 ---
readonly INSTALL_DIR="$HOME/.fuck"
readonly MAIN_SH="$INSTALL_DIR/main.sh"
# Cloudflare Edge Function 的 API 地址
readonly API_ENDPOINT="https://fuckit.sh/"


# --- 核心逻辑 (塞进一个字符串里) ---
CORE_LOGIC=$(cat <<'EOF'

# --- fuckit.sh 核心逻辑开始 ---

# --- 颜色定义 ---
# 只有在没定义过颜色的情况下才定义 (临时模式用)
if [ -z "${C_RESET:-}" ]; then
    readonly C_RESET='\033[0m'
    readonly C_RED_BOLD='\033[1;31m'
    readonly C_RED='\033[0;31m'
    readonly C_GREEN='\033[0;32m'
    readonly C_YELLOW='\033[0;33m'
    readonly C_CYAN='\033[0;36m'
    readonly C_BOLD='\033[1m'

    # --- 操! ---
    readonly FUCK="${C_RED_BOLD}操你妈!${C_RESET}"
    readonly FCKN="${C_RED}你他妈${C_RESET}"

    # --- 配置 ---
    readonly INSTALL_DIR="$HOME/.fuck"
    readonly MAIN_SH="$INSTALL_DIR/main.sh"
fi

# 找用户 shell 配置文件的辅助函数
_installer_detect_profile() {
    if [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        # 兼容 sh, ksh 等
        echo "$HOME/.profile"
    elif [ -f "$HOME/.zshrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.bashrc"
    else
        echo "unknown_profile"
    fi
}

# 检测包管理器
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

# 把系统信息整成一个字符串
_fuck_collect_sysinfo_string() {
    local pkg_manager
    pkg_manager=$(_fuck_detect_pkg_manager)
    # 服务端的 LLM 得能看懂这个字符串
    echo "OS: $(uname -s), Arch: $(uname -m), Shell: ${SHELL:-unknown}, PkgMgr: $pkg_manager, CWD: $(pwd)"
}

# JSON 转义，免得出问题
_fuck_json_escape() {
    # 就转义那几个特殊字符
    printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g'
}

# 卸载脚本
_uninstall_script() {
    echo -e "${C_RED_BOLD}我日你哥！${C_RESET}${C_YELLOW}怎么着，要卸磨杀驴？行啊你个白眼狼。${C_RESET}"

    # 找配置文件
    local profile_file
    profile_file=$(_installer_detect_profile)
    local source_line="source $MAIN_SH"

    if [ "$profile_file" != "unknown_profile" ] && [ -f "$profile_file" ]; then
        if grep -qF "$source_line" "$profile_file"; then
            # 用 sed 把那几行删了，顺便备个份
            sed -i.bak "\|$source_line|d" "$profile_file"
            sed -i.bak "\|# Added by fuckit.sh installer|d" "$profile_file"
        fi
    else
        echo -e "${C_YELLOW}找不到 shell 配置文件，你他妈自己看着办吧。${C_RESET}"
    fi

    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
    fi

    echo -e "${C_GREEN}行，我滚了，以后别他妈哭着求我回来。${C_RESET}"
    echo -e "${C_CYAN}赶紧重启你那破终端，我看着你就烦。${C_RESET}"
}

# 跟 API 通信的主函数
# 参数就是要执行的命令
_fuck_execute_prompt() {
    # 如果用户只输入 "fuck uninstall"
    if [ "$1" = "uninstall" ] && [ "$#" -eq 1 ]; then
        _uninstall_script
        return 0
    fi

    if ! command -v curl &> /dev/null; then
        echo -e "$FUCK ${C_RED}'fuck' 命令要用 'curl'，你他妈连这都没装？赶紧去装！${C_RESET}" >&2
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        echo -e "$FUCK ${C_RED}你他妈哑巴了？到底要我干啥？${C_RESET}" >&2
        return 1
    fi

    local prompt="$*"
    local sysinfo_string
    sysinfo_string=$(_fuck_collect_sysinfo_string)
    
    local escaped_prompt
    escaped_prompt=$(_fuck_json_escape "$prompt")
    
    local escaped_sysinfo
    escaped_sysinfo=$(_fuck_json_escape "$sysinfo_string")

    # 构建 JSON
    local payload
    payload=$(printf '{ "sysinfo": "%s", "prompt": "%s" }' "$escaped_sysinfo" "$escaped_prompt")

    # API 地址必须写死在这儿，不然没法用
    local api_url="https://fuckit.sh/"

    local response
    response=$(curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -d "$payload")

    if [ -z "$response" ]; then
        echo -e "$FUCK ${C_RED}AI 那孙子装死呢，屁都没放一个。${C_RESET}" >&2
        return 1
    fi

    # --- 用户确认 ---
    echo -e "${C_YELLOW}--- AI 瞎逼逼了这些，你他妈自己看吧 ---${C_RESET}"
    # 直接输出
    echo -e "${C_CYAN}$response${C_RESET}"
    echo -e "${C_YELLOW}------------------------------------------${C_RESET}"
    
    # 二次确认
    printf "${C_BOLD}${C_YELLOW}看完了没？干不干？[y/N]${C_RESET} "
    local confirmation
    read -r confirmation

    if [[ "$confirmation" =~ ^[yY]([eE][sS])?$ ]]; then
        echo -e "${C_RED_BOLD}我操你大爷！${C_RESET}${C_CYAN} 还等啥呢，干他妈的！${C_RESET}" >&2
        # 执行服务器返回的命令
        eval "$response"
        echo -e "${C_GREEN}完事了，应该没啥问题，有问题也是你的问题。${C_RESET}"
    else
        echo -e "${C_RED}怂逼！不干拉鸡巴倒！${C_RESET}" >&2
    fi
}

# 定义别名
alias fuck='_fuck_execute_prompt'

# --- 核心逻辑结束 ---
EOF
)
# --- 核心逻辑 Heredoc 结束 ---


# --- 安装函数 (由外部脚本运行) ---

# 找用户 shell 配置文件的辅助函数
_installer_detect_profile() {
    if [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "zsh"; then
        echo "$HOME/.zshrc"
    elif [ -n "${SHELL:-}" ] && echo "$SHELL" | grep -q "bash"; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        # 兼容 sh, ksh 等
        echo "$HOME/.profile"
    elif [ -f "$HOME/.zshrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        # SHELL 变量没设置时的备用方案
        echo "$HOME/.bashrc"
    else
        echo "unknown_profile"
    fi
}

# 主安装函数
_install_script() {
    echo -e "${C_BOLD}行了，开始装这破玩意儿，你他妈最好别后悔...${C_RESET}"
    mkdir -p "$INSTALL_DIR"
    
    # 把核心逻辑写进 main.sh
    echo "$CORE_LOGIC" > "$MAIN_SH"
    
    if [ $? -ne 0 ]; then
        echo -e "$FUCK ${C_RED}写不进去文件，你他妈看看权限是不是有问题。${C_RESET}" >&2
        return 1
    fi

    # 把 source 那行加到 shell 配置文件里
    local profile_file
    profile_file=$(_installer_detect_profile)
    
    if [ "$profile_file" = "unknown_profile" ]; then
        echo -e "$FUCK ${C_RED}找不到 .bashrc, .zshrc, or .profile，你他妈用的什么野鸡shell？${C_RESET}" >&2
        echo -e "${C_YELLOW}自己把这行加到你的启动文件里，别他妈指望我：${C_RESET}" >&2
        echo -e "\n  ${C_CYAN}source $MAIN_SH${C_RESET}\n" >&2
        return
    fi
    
    local source_line="source $MAIN_SH"
    if ! grep -qF "$source_line" "$profile_file"; then
        # 保证文件最后有换行
        if [ -n "$(tail -c1 "$profile_file")" ]; then
            echo "" >> "$profile_file"
        fi
        echo "# Added by fuckit.sh installer" >> "$profile_file"
        echo "$source_line" >> "$profile_file"
        echo -e "${C_RED_BOLD}我操！${C_RESET} ${C_GREEN}装好了，赶紧滚去干活，别在这儿逼逼赖赖。${C_RESET}"
        echo -e "${C_YELLOW}重启你那破终端，要不就 ${C_BOLD}source $profile_file${C_YELLOW}，赶紧的别磨叽！${C_RESET}"
        echo -e "\n${C_BOLD}--- 咋用 ---${C_RESET}"
        echo -e "就直接 ${C_RED_BOLD}fuck${C_RESET} 后边跟上你要干的破事儿就完了。"
        echo -e "比方说:"
        echo -e "  ${C_CYAN}fuck install git${C_RESET}"
        echo -e "  ${C_CYAN}fuck uninstall git${C_RESET}"
        echo -e "  ${C_CYAN}fuck 找出当前目录所有大于10MB的文件${C_RESET}"
        echo -e "  ${C_RED_BOLD}fuck uninstall${C_RESET} ${C_GREEN}# 把我自个儿卸了（卸了就卸了，谁他妈稀罕）${C_RESET}"
        echo -e "\n${C_YELLOW}记住了，重启你那破终端再用！${C_RESET}"
    else
        echo -e "$FUCK ${C_YELLOW}已经装过了，你个傻逼。帮你更新了一下脚本。${C_RESET}"
    fi
}


# --- 主脚本入口 ---

# 如果有参数传进来 (比如 "bash -s ...")
if [ "$#" -gt 0 ]; then
    # 临时模式
    # 运行核心逻辑，定义函数
    eval "$CORE_LOGIC"
    # 直接调用主函数 (别名在这儿不好使)
    _fuck_execute_prompt "$@"
else
    # 安装模式
    _install_script
fi