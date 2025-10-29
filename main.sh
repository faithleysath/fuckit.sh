#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.4.0-alpha
# date: 2025-10-29 14:47:27
starts_with__20_v0() {
    local text=$1
    local prefix=$2
    __AMBER_VAL_0=$( if [[ "${text}" == "${prefix}"* ]]; then
    echo 1
  fi );
    __AS=$?;
    local result="${__AMBER_VAL_0}"
    __AF_starts_with20_v0=$([ "_${result}" != "_1" ]; echo $?);
    return 0
}

env_var_get__91_v0() {
    local name=$1
    __AMBER_VAL_1=$( echo ${!name} );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_env_var_get91_v0=''
return $__AS
fi;
    __AF_env_var_get91_v0="${__AMBER_VAL_1}";
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
    __AMBER_ARRAY_2=("${message}");
    printf__99_v0 "\x1b[1;3;97;44m%s\x1b[0m
" __AMBER_ARRAY_2[@];
    __AF_printf99_v0__147_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__147_5" > /dev/null 2>&1
}
echo_warning__108_v0() {
    local message=$1
    __AMBER_ARRAY_3=("${message}");
    printf__99_v0 "\x1b[1;3;97;43m%s\x1b[0m
" __AMBER_ARRAY_3[@];
    __AF_printf99_v0__157_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__157_5" > /dev/null 2>&1
}
echo_error__109_v0() {
    local message=$1
    local exit_code=$2
    __AMBER_ARRAY_4=("${message}");
    printf__99_v0 "\x1b[1;3;97;41m%s\x1b[0m
" __AMBER_ARRAY_4[@];
    __AF_printf99_v0__162_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__162_5" > /dev/null 2>&1
    if [ $(echo ${exit_code} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit ${exit_code}
fi
}
array_find__115_v0() {
    local array=("${!1}")
    local value=$2
    index=0;
for element in "${array[@]}"; do
        if [ $([ "_${value}" != "_${element}" ]; echo $?) != 0 ]; then
            __AF_array_find115_v0=${index};
            return 0
fi
    (( index++ )) || true
done
    __AF_array_find115_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
array_contains__117_v0() {
    local array=("${!1}")
    local value=$2
    array_find__115_v0 array[@] "${value}";
    __AF_array_find115_v0__26_18="$__AF_array_find115_v0";
    local result="$__AF_array_find115_v0__26_18"
    __AF_array_contains117_v0=$(echo ${result} '>=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
# Check for dependencies first

if ! command -v bc > /dev/null 2>&1; then
    echo "Dependency check failed: 'bc' command not found. Please install 'bc' and try again." >&2
    echo "  - Debian/Ubuntu: sudo apt-get install bc" >&2
    echo "  - RedHat/CentOS: sudo yum install bc" >&2
    echo "  - Fedora:        sudo dnf install bc" >&2
    echo "  - Arch Linux:    sudo pacman -S bc" >&2
    echo "  - openSUSE:      sudo zypper install bc" >&2
    echo "  - Alpine:        apk add bc" >&2
    exit 1
fi
;
__AS=$?
__0_VERSION="0.1.0"
__1_LANG="en"
install__125_v0() {
    local home_dir=$1
    echo_info__106_v0 "Entering Install Mode...";
    __AF_echo_info106_v0__23_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__23_5" > /dev/null 2>&1
}
declare -r arguments=("$0" "$@")
    # Handle zero arguments case (although this should not happen)
    if [ $(echo "${#arguments[@]}" '<' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Oops, no arguments provided"'!'" It should not happen. But it did. Please visit https://fuckit.sh and report this issue." 1;
        __AF_echo_error109_v0__29_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__29_9" > /dev/null 2>&1
fi
    # First argument is the script name
    script_name="${arguments[0]}"
    # Remaining arguments are passed to the script
    __SLICE_UPPER_5="${#arguments[@]}";
    __SLICE_OFFSET_6=1;
    __SLICE_OFFSET_6=$((__SLICE_OFFSET_6 > 0 ? __SLICE_OFFSET_6 : 0));
    __SLICE_LENGTH_7=$(echo "${#arguments[@]}" '-' $__SLICE_OFFSET_6 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __SLICE_LENGTH_7=$((__SLICE_LENGTH_7 > 0 ? __SLICE_LENGTH_7 : 0));
    script_args=("${arguments[@]:$__SLICE_OFFSET_6:$__SLICE_LENGTH_7}")
    # Get the home directory from environment variable
    env_var_get__91_v0 "HOME";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_warning__108_v0 "HOME environment variable is not set. Install Mode disabled.";
        __AF_echo_warning108_v0__36_9="$__AF_echo_warning108_v0";
        echo "$__AF_echo_warning108_v0__36_9" > /dev/null 2>&1
fi;
    __AF_env_var_get91_v0__35_20="${__AF_env_var_get91_v0}";
    home_dir="${__AF_env_var_get91_v0__35_20}"
    # Check if entering install mode or normal execution
    starts_with__20_v0 "${script_name}" "${home_dir}""/.local/bin";
    __AF_starts_with20_v0__42_60="$__AF_starts_with20_v0";
    __AMBER_ARRAY_8=("-v" "--version" "version");
    array_contains__117_v0 __AMBER_ARRAY_8[@] "${script_args[0]}";
    __AF_array_contains117_v0__49_35="$__AF_array_contains117_v0";
    if [ $(echo $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo  '!' "$__AF_starts_with20_v0__42_60" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        install__125_v0 "${home_dir}";
        __AF_install125_v0__42_113="$__AF_install125_v0";
        echo "$__AF_install125_v0__42_113" > /dev/null 2>&1
elif [ $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Install failed: HOME environment variable is not set. Try 'export HOME=~' and run again." 1;
        __AF_echo_error109_v0__46_13="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__46_13" > /dev/null 2>&1
elif [ $(echo $(echo "${#script_args[@]}" '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' "$__AF_array_contains117_v0__49_35" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo "${__0_VERSION}"
else
        echo_info__106_v0 "Entering Normal Execution Mode...";
        __AF_echo_info106_v0__54_13="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__54_13" > /dev/null 2>&1
        # Call normal execution function, e.g., execute(script_args)
fi
