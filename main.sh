#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.4.0-alpha
# date: 2025-10-29 16:36:12
split__3_v0() {
    local text=$1
    local delimiter=$2
    __AMBER_ARRAY_0=();
    local result=("${__AMBER_ARRAY_0[@]}")
     IFS="${delimiter}" read -rd '' -a result < <(printf %s "$text") ;
    __AS=$?
    __AF_split3_v0=("${result[@]}");
    return 0
}
parse_number__12_v0() {
    local text=$1
     [ -n "${text}" ] && [ "${text}" -eq "${text}" ] 2>/dev/null ;
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_parse_number12_v0=''
return $__AS
fi
    __AF_parse_number12_v0="${text}";
    return 0
}
starts_with__20_v0() {
    local text=$1
    local prefix=$2
    __AMBER_VAL_1=$( if [[ "${text}" == "${prefix}"* ]]; then
    echo 1
  fi );
    __AS=$?;
    local result="${__AMBER_VAL_1}"
    __AF_starts_with20_v0=$([ "_${result}" != "_1" ]; echo $?);
    return 0
}
dir_exists__32_v0() {
    local path=$1
     [ -d "${path}" ] ;
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_dir_exists32_v0=0;
        return 0
fi
    __AF_dir_exists32_v0=1;
    return 0
}
file_exists__33_v0() {
    local path=$1
     [ -f "${path}" ] ;
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_file_exists33_v0=0;
        return 0
fi
    __AF_file_exists33_v0=1;
    return 0
}
dir_create__38_v0() {
    local path=$1
    dir_exists__32_v0 "${path}";
    __AF_dir_exists32_v0__52_12="$__AF_dir_exists32_v0";
    if [ $(echo  '!' "$__AF_dir_exists32_v0__52_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         mkdir -p "${path}" ;
        __AS=$?
fi
}
file_chmod__39_v0() {
    local path=$1
    local mode=$2
    file_exists__33_v0 "${path}";
    __AF_file_exists33_v0__61_8="$__AF_file_exists33_v0";
    if [ "$__AF_file_exists33_v0__61_8" != 0 ]; then
         chmod "${mode}" "${path}" ;
        __AS=$?
        __AF_file_chmod39_v0=1;
        return 0
fi
    echo "The file ${path} doesn't exist"'!'""
    __AF_file_chmod39_v0=0;
    return 0
}
env_var_get__91_v0() {
    local name=$1
    __AMBER_VAL_2=$( echo ${!name} );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_env_var_get91_v0=''
return $__AS
fi;
    __AF_env_var_get91_v0="${__AMBER_VAL_2}";
    return 0
}
is_command__93_v0() {
    local command=$1
     [ -x "$(command -v ${command})" ] ;
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_is_command93_v0=0;
        return 0
fi
    __AF_is_command93_v0=1;
    return 0
}
printf__99_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" ;
    __AS=$?
}
echo_info__106_v0() {
    local message=$1
    __AMBER_ARRAY_3=("${message}");
    printf__99_v0 "\x1b[1;3;97;44m%s\x1b[0m
" __AMBER_ARRAY_3[@];
    __AF_printf99_v0__147_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__147_5" > /dev/null 2>&1
}
echo_success__107_v0() {
    local message=$1
    __AMBER_ARRAY_4=("${message}");
    printf__99_v0 "\x1b[1;3;97;42m%s\x1b[0m
" __AMBER_ARRAY_4[@];
    __AF_printf99_v0__152_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__152_5" > /dev/null 2>&1
}
echo_warning__108_v0() {
    local message=$1
    __AMBER_ARRAY_5=("${message}");
    printf__99_v0 "\x1b[1;3;97;43m%s\x1b[0m
" __AMBER_ARRAY_5[@];
    __AF_printf99_v0__157_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__157_5" > /dev/null 2>&1
}
echo_error__109_v0() {
    local message=$1
    local exit_code=$2
    __AMBER_ARRAY_6=("${message}");
    printf__99_v0 "\x1b[1;3;97;41m%s\x1b[0m
" __AMBER_ARRAY_6[@];
    __AF_printf99_v0__162_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__162_5" > /dev/null 2>&1
    if [ $(echo ${exit_code} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit ${exit_code}
fi
}
array_find__118_v0() {
    local array=("${!1}")
    local value=$2
    index=0;
for element in "${array[@]}"; do
        if [ $([ "_${value}" != "_${element}" ]; echo $?) != 0 ]; then
            __AF_array_find118_v0=${index};
            return 0
fi
    (( index++ )) || true
done
    __AF_array_find118_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
array_contains__120_v0() {
    local array=("${!1}")
    local value=$2
    array_find__118_v0 array[@] "${value}";
    __AF_array_find118_v0__26_18="$__AF_array_find118_v0";
    local result="$__AF_array_find118_v0__26_18"
    __AF_array_contains120_v0=$(echo ${result} '>=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
file_download__156_v0() {
    local url=$1
    local path=$2
    is_command__93_v0 "curl";
    __AF_is_command93_v0__9_9="$__AF_is_command93_v0";
    is_command__93_v0 "wget";
    __AF_is_command93_v0__12_9="$__AF_is_command93_v0";
    is_command__93_v0 "aria2c";
    __AF_is_command93_v0__15_9="$__AF_is_command93_v0";
    if [ "$__AF_is_command93_v0__9_9" != 0 ]; then
         curl -L -o "${path}" "${url}" ;
        __AS=$?
elif [ "$__AF_is_command93_v0__12_9" != 0 ]; then
         wget "${url}" -P "${path}" ;
        __AS=$?
elif [ "$__AF_is_command93_v0__15_9" != 0 ]; then
         aria2c "${url}" -d "${path}" ;
        __AS=$?
else
        __AF_file_download156_v0=0;
        return 0
fi
    __AF_file_download156_v0=1;
    return 0
}
__0_VERSION="0.1.0"
__1_LANG="en"
__2_NAME="fuck"
# const URL = "https://fuckit.sh"
__3_URL="http://127.0.0.1:5500/main.sh"
# Check for dependencies first, need _ to avoid stray semicolon. If you can't understand, just keep it as is. It's not a bug, just to fit the compiler's behavior.
__AMBER_VAL_7=$(
if ! command -v bc > /dev/null 2>&1; then
    echo -e "\033[0;31mDependency check failed: 'bc' command not found. Please install 'bc' and try again.\033[0m" >&2
    echo "  - Debian/Ubuntu: sudo apt-get install bc" >&2
    echo "  - RedHat/CentOS: sudo yum install bc" >&2
    echo "  - Fedora:        sudo dnf install bc" >&2
    echo "  - Arch Linux:    sudo pacman -S bc" >&2
    echo "  - openSUSE:      sudo zypper install bc" >&2
    echo "  - Alpine:        apk add bc" >&2
    exit 1
fi
);
__AS=$?;
__4__="${__AMBER_VAL_7}"
compare_versions__158_v0() {
    local v1=$1
    local v2=$2
    split__3_v0 "${v1}" ".";
    __AF_split3_v0__28_18=("${__AF_split3_v0[@]}");
    local parts1=("${__AF_split3_v0__28_18[@]}")
    split__3_v0 "${v2}" ".";
    __AF_split3_v0__29_18=("${__AF_split3_v0[@]}");
    local parts2=("${__AF_split3_v0__29_18[@]}")
    local len1="${#parts1[@]}"
    local len2="${#parts2[@]}"
    local max_len=$(if [ $(echo ${len1} '>' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo ${len1}; else echo ${len2}; fi)
    for i in $(seq 0 $(echo ${max_len} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        # If part is missing, treat it as 0
        parse_number__12_v0 "${parts1[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions158_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__38_34="$__AF_parse_number12_v0";
        local num1=$(if [ $(echo ${i} '<' ${len1} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__38_34"; else echo 0; fi)
        parse_number__12_v0 "${parts2[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions158_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__39_34="$__AF_parse_number12_v0";
        local num2=$(if [ $(echo ${i} '<' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__39_34"; else echo 0; fi)
        if [ $(echo ${num1} '>' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions158_v0=1;
            return 0
fi
        if [ $(echo ${num1} '<' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions158_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            return 0
fi
done
    __AF_compare_versions158_v0=0;
    return 0
}
install__159_v0() {
    local home_dir=$1
    # First, check if already installed, just check version command directly
    __AMBER_VAL_8=$( ${__2_NAME} --version );
    __AS=$?;
if [ $__AS != 0 ]; then
        local current_version=""
fi;
    local current_version="${__AMBER_VAL_8}"
    if [ $([ "_${current_version}" != "_" ]; echo $?) != 0 ]; then
        echo_info__106_v0 "fuckit.sh is not installed. Installing now...";
        __AF_echo_info106_v0__53_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__53_9" > /dev/null 2>&1
else
        compare_versions__158_v0 "${current_version}" "${__0_VERSION}";
        __AS=$?;
if [ $__AS != 0 ]; then
            local comparison=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi;
        __AF_compare_versions158_v0__55_26="$__AF_compare_versions158_v0";
        local comparison="$__AF_compare_versions158_v0__55_26"
        if [ $(echo ${comparison} '==' $(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            echo_info__106_v0 "A new version (${__0_VERSION}) is available. Your current version is ${current_version}. Updating...";
            __AF_echo_info106_v0__57_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__57_13" > /dev/null 2>&1
else
            echo_info__106_v0 "You are already using the latest version (${current_version}).";
            __AF_echo_info106_v0__59_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__59_13" > /dev/null 2>&1
            exit 0
fi
fi
    # Installation / Update process (they are the same here)
    # Step1: Check if the dir exists
    local bin_dir="${home_dir}""/.local/bin"
    local bin_path="${bin_dir}""/""${__2_NAME}"
    dir_exists__32_v0 "${bin_dir}";
    __AF_dir_exists32_v0__68_12="$__AF_dir_exists32_v0";
    if [ $(echo  '!' "$__AF_dir_exists32_v0__68_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_info__106_v0 "Directory '${bin_dir}' does not exist. Creating it...";
        __AF_echo_info106_v0__69_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__69_9" > /dev/null 2>&1
        dir_create__38_v0 "${bin_dir}";
        __AF_dir_create38_v0__70_9="$__AF_dir_create38_v0";
        echo "$__AF_dir_create38_v0__70_9" > /dev/null 2>&1
fi
    # Step2: Check if bin_dir is in PATH
    env_var_get__91_v0 "PATH";
    __AS=$?;
    __AF_env_var_get91_v0__73_26="${__AF_env_var_get91_v0}";
    local path_env="${__AF_env_var_get91_v0__73_26}"
    # Step3: Download the script and place it in bin_dir
    echo_info__106_v0 "Downloading 'fuckit.sh' to '${bin_dir}'...(via ${__3_URL})";
    __AF_echo_info106_v0__75_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__75_5" > /dev/null 2>&1
    file_download__156_v0 "${__3_URL}" "${bin_path}";
    __AF_file_download156_v0__76_12="$__AF_file_download156_v0";
    if [ $(echo  '!' "$__AF_file_download156_v0__76_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "No Avaliable CLI Tools Found, Need curl, wget or aria2c." 1;
        __AF_echo_error109_v0__77_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__77_9" > /dev/null 2>&1
fi
    # Step4: Make it executable
    file_chmod__39_v0 "${bin_path}" "+x";
    __AF_file_chmod39_v0__79_12="$__AF_file_chmod39_v0";
    if [ $(echo  '!' "$__AF_file_chmod39_v0__79_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Failed to set executable permission on '${bin_path}'." 1;
        __AF_echo_error109_v0__80_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__80_9" > /dev/null 2>&1
fi
    # Step5: Verify installation
    __AMBER_VAL_9=$( ${bin_path} --version );
    __AS=$?;
if [ $__AS != 0 ]; then
        local installed_version=""
fi;
    local installed_version="${__AMBER_VAL_9}"
    if [ $([ "_${installed_version}" != "_" ]; echo $?) != 0 ]; then
        echo "Verbose Information:"
        echo "  - Home Directory: ${home_dir}"
        echo "  - Binary Path: ${bin_path}"
        echo "  - Target Version: ${__0_VERSION}"
        echo "  - Current Version: ${current_version}"
        echo "  - Installed Version: ${installed_version}"
        echo "  - PATH: ${path_env}"
        echo_error__109_v0 "Installation failed: Unable to verify installation. (It means executing '${bin_path} --version' did not return any output or just failed.) Please check the above information and try again." 1;
        __AF_echo_error109_v0__91_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__91_9" > /dev/null 2>&1
else
        echo_success__107_v0 "fuckit.sh version ${installed_version} installed successfully at '${bin_path}'"'!'"";
        __AF_echo_success107_v0__93_9="$__AF_echo_success107_v0";
        echo "$__AF_echo_success107_v0__93_9" > /dev/null 2>&1
fi
    # Step6: Warn if bin_dir is not in PATH
    split__3_v0 "${path_env}" ":";
    __AF_split3_v0__95_46=("${__AF_split3_v0[@]}");
    array_contains__120_v0 __AF_split3_v0__95_46[@] "${bin_dir}";
    __AF_array_contains120_v0__95_31="$__AF_array_contains120_v0";
    if [ $(echo $([ "_${path_env}" == "_" ]; echo $?) '&&' $(echo  '!' "$__AF_array_contains120_v0__95_31" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_warning__108_v0 "Warning: '${bin_dir}' is not in your PATH environment variable. You may need to add it manually to run 'fuckit.sh' easily.";
        __AF_echo_warning108_v0__96_9="$__AF_echo_warning108_v0";
        echo "$__AF_echo_warning108_v0__96_9" > /dev/null 2>&1
        echo_info__106_v0 "You can add the following line to your shell profile (e.g., ~/.bashrc, ~/.zshrc):";
        __AF_echo_info106_v0__97_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__97_9" > /dev/null 2>&1
        echo_info__106_v0 "export PATH=\"${bin_dir}:$PATH\"";
        __AF_echo_info106_v0__98_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__98_9" > /dev/null 2>&1
fi
}
declare -r arguments=("$0" "$@")
    # Handle zero arguments case (although this should not happen)
    if [ $(echo "${#arguments[@]}" '<' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Oops, no arguments provided"'!'" It should not happen. But it did. Please visit https://fuckit.sh and report this issue." 1;
        __AF_echo_error109_v0__105_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__105_9" > /dev/null 2>&1
fi
    # First argument is the script name
    script_name="${arguments[0]}"
    # Remaining arguments are passed to the script
    __SLICE_UPPER_10="${#arguments[@]}";
    __SLICE_OFFSET_11=1;
    __SLICE_OFFSET_11=$((__SLICE_OFFSET_11 > 0 ? __SLICE_OFFSET_11 : 0));
    __SLICE_LENGTH_12=$(echo "${#arguments[@]}" '-' $__SLICE_OFFSET_11 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __SLICE_LENGTH_12=$((__SLICE_LENGTH_12 > 0 ? __SLICE_LENGTH_12 : 0));
    script_args=("${arguments[@]:$__SLICE_OFFSET_11:$__SLICE_LENGTH_12}")
    # Get the home directory from environment variable
    env_var_get__91_v0 "HOME";
    __AS=$?;
    __AF_env_var_get91_v0__111_26="${__AF_env_var_get91_v0}";
    home_dir="${__AF_env_var_get91_v0__111_26}"
    # Check execution mode
    __AMBER_ARRAY_13=("-v" "--version" "version");
    array_contains__120_v0 __AMBER_ARRAY_13[@] "${script_args[0]}";
    __AF_array_contains120_v0__116_35="$__AF_array_contains120_v0";
    starts_with__20_v0 "${script_name}" "${home_dir}""/.local/bin";
    __AF_starts_with20_v0__124_39="$__AF_starts_with20_v0";
    if [ $(echo $(echo "${#script_args[@]}" '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' "$__AF_array_contains120_v0__116_35" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo "${__0_VERSION}"
elif [ $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${home_dir}" != "_" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Install failed: HOME environment variable is not set. Try 'export HOME=~' and run again." 1;
        __AF_echo_error109_v0__121_13="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__121_13" > /dev/null 2>&1
elif [ $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo  '!' "$__AF_starts_with20_v0__124_39" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        install__159_v0 "${home_dir}";
        __AF_install159_v0__125_13="$__AF_install159_v0";
        echo "$__AF_install159_v0__125_13" > /dev/null 2>&1
else
        echo_info__106_v0 "Entering Normal Execution Mode...";
        __AF_echo_info106_v0__129_13="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__129_13" > /dev/null 2>&1
        echo "Usage: ${__2_NAME} [options]"
fi
