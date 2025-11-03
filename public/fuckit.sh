#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.4.0-alpha
# date: 2025-11-03 23:10:06
replace__0_v0() {
    local source=$1
    local search=$2
    local replace=$3
    __AF_replace0_v0="${source//${search}/${replace}}";
    return 0
}
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
split_lines__4_v0() {
    local text=$1
    split__3_v0 "${text}" "
";
    __AF_split3_v0__40_12=("${__AF_split3_v0[@]}");
    __AF_split_lines4_v0=("${__AF_split3_v0__40_12[@]}");
    return 0
}
join__6_v0() {
    local list=("${!1}")
    local delimiter=$2
    __AMBER_VAL_1=$( IFS="${delimiter}" ; echo "${list[*]}" );
    __AS=$?;
    __AF_join6_v0="${__AMBER_VAL_1}";
    return 0
}
trim_left__7_v0() {
    local text=$1
    __AMBER_VAL_2=$( echo "${text}" | sed -e 's/^[[:space:]]*//' );
    __AS=$?;
    __AF_trim_left7_v0="${__AMBER_VAL_2}";
    return 0
}
trim_right__8_v0() {
    local text=$1
    __AMBER_VAL_3=$( echo "${text}" | sed -e 's/[[:space:]]*$//' );
    __AS=$?;
    __AF_trim_right8_v0="${__AMBER_VAL_3}";
    return 0
}
trim__9_v0() {
    local text=$1
    trim_right__8_v0 "${text}";
    __AF_trim_right8_v0__65_22="${__AF_trim_right8_v0}";
    trim_left__7_v0 "${__AF_trim_right8_v0__65_22}";
    __AF_trim_left7_v0__65_12="${__AF_trim_left7_v0}";
    __AF_trim9_v0="${__AF_trim_left7_v0__65_12}";
    return 0
}
lowercase__10_v0() {
    local text=$1
    __AMBER_VAL_4=$( echo "${text}" | tr '[:upper:]' '[:lower:]' );
    __AS=$?;
    __AF_lowercase10_v0="${__AMBER_VAL_4}";
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
split_chars__13_v0() {
    local text=$1
    __AMBER_ARRAY_5=();
    local chars=("${__AMBER_ARRAY_5[@]}")
     for ((i=0; i<${#text}; i++)); do
        chars+=( "${text:$i:1}" );
    done ;
    __AS=$?
    __AF_split_chars13_v0=("${chars[@]}");
    return 0
}
starts_with__20_v0() {
    local text=$1
    local prefix=$2
    __AMBER_VAL_6=$( if [[ "${text}" == "${prefix}"* ]]; then
    echo 1
  fi );
    __AS=$?;
    local result="${__AMBER_VAL_6}"
    __AF_starts_with20_v0=$([ "_${result}" != "_1" ]; echo $?);
    return 0
}
ends_with__21_v0() {
    local text=$1
    local suffix=$2
    __AMBER_VAL_7=$( if [[ "${text}" == *"${suffix}" ]]; then
    echo 1
  fi );
    __AS=$?;
    local result="${__AMBER_VAL_7}"
    __AF_ends_with21_v0=$([ "_${result}" != "_1" ]; echo $?);
    return 0
}
slice__22_v0() {
    local text=$1
    local index=$2
    local length=$3
    if [ $(echo ${length} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_LEN="${text}";
        length=$(echo "${#__AMBER_LEN}" '-' ${index} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    if [ $(echo ${length} '<=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_slice22_v0="";
        return 0
fi
    __AMBER_VAL_8=$( printf "%.${length}s" "${text:${index}}" );
    __AS=$?;
    __AF_slice22_v0="${__AMBER_VAL_8}";
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
file_read__34_v0() {
    local path=$1
    __AMBER_VAL_9=$( < "${path}" );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_read34_v0=''
return $__AS
fi;
    __AF_file_read34_v0="${__AMBER_VAL_9}";
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
env_var_set__90_v0() {
    local name=$1
    local val=$2
     export $name="$val" 2> /dev/null ;
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_env_var_set90_v0=''
return $__AS
fi
}
env_var_get__91_v0() {
    local name=$1
    __AMBER_VAL_10=$( echo ${!name} );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_env_var_get91_v0=''
return $__AS
fi;
    __AF_env_var_get91_v0="${__AMBER_VAL_10}";
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
input_prompt__94_v0() {
    local prompt=$1
     read -p "$prompt" ;
    __AS=$?
    __AF_input_prompt94_v0="$REPLY";
    return 0
}
input_confirm__96_v0() {
    local prompt=$1
    local default_yes=$2
    local choice_default=$(if [ ${default_yes} != 0 ]; then echo " [\x1b[1mY/\x1b[0mn]"; else echo " [y/\x1b[1mN\x1b[0m]"; fi)
             printf "\x1b[1m${prompt}\x1b[0m${choice_default}" ;
        __AS=$?
         read -s -n 1 ;
        __AS=$?
         printf "
" ;
        __AS=$?
    __AMBER_VAL_11=$( echo $REPLY );
    __AS=$?;
    lowercase__10_v0 "${__AMBER_VAL_11}";
    __AF_lowercase10_v0__90_18="${__AF_lowercase10_v0}";
    local result="${__AF_lowercase10_v0__90_18}"
    __AF_input_confirm96_v0=$(echo $([ "_${result}" != "_y" ]; echo $?) '||' $(echo $([ "_${result}" != "_" ]; echo $?) '&&' ${default_yes} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
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
    __AMBER_ARRAY_12=("${message}");
    printf__99_v0 "\x1b[1;3;97;44m%s\x1b[0m
" __AMBER_ARRAY_12[@];
    __AF_printf99_v0__147_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__147_5" > /dev/null 2>&1
}
echo_success__107_v0() {
    local message=$1
    __AMBER_ARRAY_13=("${message}");
    printf__99_v0 "\x1b[1;3;97;42m%s\x1b[0m
" __AMBER_ARRAY_13[@];
    __AF_printf99_v0__152_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__152_5" > /dev/null 2>&1
}
echo_warning__108_v0() {
    local message=$1
    __AMBER_ARRAY_14=("${message}");
    printf__99_v0 "\x1b[1;3;97;43m%s\x1b[0m
" __AMBER_ARRAY_14[@];
    __AF_printf99_v0__157_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__157_5" > /dev/null 2>&1
}
echo_error__109_v0() {
    local message=$1
    local exit_code=$2
    __AMBER_ARRAY_15=("${message}");
    printf__99_v0 "\x1b[1;3;97;41m%s\x1b[0m
" __AMBER_ARRAY_15[@];
    __AF_printf99_v0__162_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__162_5" > /dev/null 2>&1
    if [ $(echo ${exit_code} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit ${exit_code}
fi
}
array_find__119_v0() {
    local array=("${!1}")
    local value=$2
    index=0;
for element in "${array[@]}"; do
        if [ $([ "_${value}" != "_${element}" ]; echo $?) != 0 ]; then
            __AF_array_find119_v0=${index};
            return 0
fi
    (( index++ )) || true
done
    __AF_array_find119_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
array_contains__121_v0() {
    local array=("${!1}")
    local value=$2
    array_find__119_v0 array[@] "${value}";
    __AF_array_find119_v0__26_18="$__AF_array_find119_v0";
    local result="$__AF_array_find119_v0__26_18"
    __AF_array_contains121_v0=$(echo ${result} '>=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}




file_download__202_v0() {
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
        __AF_file_download202_v0=0;
        return 0
fi
    __AF_file_download202_v0=1;
    return 0
}
compare_versions__206_v0() {
    local v1=$1
    local v2=$2
    split__3_v0 "${v1}" ".";
    __AF_split3_v0__4_18=("${__AF_split3_v0[@]}");
    local parts1=("${__AF_split3_v0__4_18[@]}")
    split__3_v0 "${v2}" ".";
    __AF_split3_v0__5_18=("${__AF_split3_v0[@]}");
    local parts2=("${__AF_split3_v0__5_18[@]}")
    local len1="${#parts1[@]}"
    local len2="${#parts2[@]}"
    local max_len=$(if [ $(echo ${len1} '>' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo ${len1}; else echo ${len2}; fi)
    for i in $(seq 0 $(echo ${max_len} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        # If part is missing, treat it as 0
        parse_number__12_v0 "${parts1[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions206_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__14_34="$__AF_parse_number12_v0";
        local num1=$(if [ $(echo ${i} '<' ${len1} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__14_34"; else echo 0; fi)
        parse_number__12_v0 "${parts2[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions206_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__15_34="$__AF_parse_number12_v0";
        local num2=$(if [ $(echo ${i} '<' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__15_34"; else echo 0; fi)
        if [ $(echo ${num1} '>' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions206_v0=1;
            return 0
fi
        if [ $(echo ${num1} '<' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions206_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            return 0
fi
done
    __AF_compare_versions206_v0=0;
    return 0
}
install__208_v0() {
    local home_dir=$1
    local name=$2
    local civil_name=$3
    local version=$4
    local url=$5
    # First, check if already installed, just check version command directly
    __AMBER_VAL_16=$( ${name} --version 2> /dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
        local current_version=""
fi;
    local current_version="${__AMBER_VAL_16}"
    if [ $([ "_${current_version}" != "_" ]; echo $?) != 0 ]; then
        env_var_get__91_v0 "MSG_INSTALL_START";
        __AS=$?;
        __AF_env_var_get91_v0__13_25="${__AF_env_var_get91_v0}";
        echo_info__106_v0 "${__AF_env_var_get91_v0__13_25}";
        __AF_echo_info106_v0__13_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__13_9" > /dev/null 2>&1
else
        compare_versions__206_v0 "${current_version}" "${version}";
        __AS=$?;
if [ $__AS != 0 ]; then
            local comparison=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi;
        __AF_compare_versions206_v0__15_26="$__AF_compare_versions206_v0";
        local comparison="$__AF_compare_versions206_v0__15_26"
        if [ $(echo ${comparison} '==' $(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            env_var_get__91_v0 "MSG_INSTALL_UPGRADE_AVAILABLE";
            __AS=$?;
            __AF_env_var_get91_v0__17_29="${__AF_env_var_get91_v0}";
            local tpl="${__AF_env_var_get91_v0__17_29}"
            replace__0_v0 "${tpl}" "{version}" "${version}";
            __AF_replace0_v0__18_31="${__AF_replace0_v0}";
            replace__0_v0 "${__AF_replace0_v0__18_31}" "{current_version}" "${current_version}";
            __AF_replace0_v0__18_23="${__AF_replace0_v0}";
            local msg="${__AF_replace0_v0__18_23}"
            echo_warning__108_v0 "${msg}";
            __AF_echo_warning108_v0__19_13="$__AF_echo_warning108_v0";
            echo "$__AF_echo_warning108_v0__19_13" > /dev/null 2>&1
else
            env_var_get__91_v0 "MSG_INSTALL_LATEST";
            __AS=$?;
            __AF_env_var_get91_v0__21_29="${__AF_env_var_get91_v0}";
            local tpl="${__AF_env_var_get91_v0__21_29}"
            replace__0_v0 "${tpl}" "{current_version}" "${current_version}";
            __AF_replace0_v0__22_23="${__AF_replace0_v0}";
            local msg="${__AF_replace0_v0__22_23}"
            echo_info__106_v0 "${msg}";
            __AF_echo_info106_v0__23_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__23_13" > /dev/null 2>&1
            exit 0
fi
fi
    if [ $([ "_${home_dir}" != "_" ]; echo $?) != 0 ]; then
        env_var_get__91_v0 "MSG_ERR_NO_HOME";
        __AS=$?;
        __AF_env_var_get91_v0__28_26="${__AF_env_var_get91_v0}";
        echo_error__109_v0 "${__AF_env_var_get91_v0__28_26}" 1;
        __AF_echo_error109_v0__28_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__28_9" > /dev/null 2>&1
fi
    # Installation / Update process (they are the same here)
    # Step1: Check if the dir exists
    local bin_dir="${home_dir}""/.local/bin"
    local bin_path="${bin_dir}""/""${name}"
    dir_exists__32_v0 "${bin_dir}";
    __AF_dir_exists32_v0__34_12="$__AF_dir_exists32_v0";
    if [ $(echo  '!' "$__AF_dir_exists32_v0__34_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_INSTALL_CREATE_DIR";
        __AS=$?;
        __AF_env_var_get91_v0__35_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__35_25}"
        replace__0_v0 "${tpl}" "{bin_dir}" "${bin_dir}";
        __AF_replace0_v0__36_19="${__AF_replace0_v0}";
        local msg="${__AF_replace0_v0__36_19}"
        echo_info__106_v0 "${msg}";
        __AF_echo_info106_v0__37_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__37_9" > /dev/null 2>&1
        dir_create__38_v0 "${bin_dir}";
        __AF_dir_create38_v0__38_9="$__AF_dir_create38_v0";
        echo "$__AF_dir_create38_v0__38_9" > /dev/null 2>&1
fi
    # Step2: Check if bin_dir is in PATH
    env_var_get__91_v0 "PATH";
    __AS=$?;
    __AF_env_var_get91_v0__41_26="${__AF_env_var_get91_v0}";
    local path_env="${__AF_env_var_get91_v0__41_26}"
    # Step3: Download the script and place it in bin_dir
    env_var_get__91_v0 "MSG_INSTALL_DOWNLOADING";
    __AS=$?;
    __AF_env_var_get91_v0__43_30="${__AF_env_var_get91_v0}";
    local tpl_download="${__AF_env_var_get91_v0__43_30}"
    replace__0_v0 "${tpl_download}" "{bin_dir}" "${bin_dir}";
    __AF_replace0_v0__44_32="${__AF_replace0_v0}";
    replace__0_v0 "${__AF_replace0_v0__44_32}" "{url}" "${url}";
    __AF_replace0_v0__44_24="${__AF_replace0_v0}";
    local msg_download="${__AF_replace0_v0__44_24}"
    echo_info__106_v0 "${msg_download}";
    __AF_echo_info106_v0__45_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__45_5" > /dev/null 2>&1
    file_download__202_v0 "${url}" "${bin_path}";
    __AF_file_download202_v0__46_12="$__AF_file_download202_v0";
    if [ $(echo  '!' "$__AF_file_download202_v0__46_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_ERR_NO_DOWNLOADER";
        __AS=$?;
        __AF_env_var_get91_v0__47_26="${__AF_env_var_get91_v0}";
        echo_error__109_v0 "${__AF_env_var_get91_v0__47_26}" 1;
        __AF_echo_error109_v0__47_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__47_9" > /dev/null 2>&1
fi
    # Step4: Make it executable
    file_chmod__39_v0 "${bin_path}" "+x";
    __AF_file_chmod39_v0__49_12="$__AF_file_chmod39_v0";
    if [ $(echo  '!' "$__AF_file_chmod39_v0__49_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_ERR_CHMOD_FAILED";
        __AS=$?;
        __AF_env_var_get91_v0__50_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__50_25}"
fi
    replace__0_v0 "${tpl}" "{bin_path}" "${bin_path}";
    __AF_replace0_v0__51_19="${__AF_replace0_v0}";
    local msg="${__AF_replace0_v0__51_19}"
    echo_error__109_v0 "${msg}" 1;
    __AF_echo_error109_v0__52_9="$__AF_echo_error109_v0";
    echo "$__AF_echo_error109_v0__52_9" > /dev/null 2>&1
    # Step5: Verify installation
    __AMBER_VAL_17=$( ${bin_path} --version 2> /dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
        local installed_version=""
fi;
    local installed_version="${__AMBER_VAL_17}"
    if [ $([ "_${installed_version}" != "_" ]; echo $?) != 0 ]; then
        echo "Verbose Information:"
        echo "  - Home Directory: ${home_dir}"
        echo "  - Binary Path: ${bin_path}"
        echo "  - Target Version: ${version}"
        echo "  - Current Version: ${current_version}"
        echo "  - Installed Version: ${installed_version}"
        echo "  - PATH: ${path_env}"
        env_var_get__91_v0 "MSG_ERR_INSTALL_FAILED";
        __AS=$?;
        __AF_env_var_get91_v0__63_26="${__AF_env_var_get91_v0}";
        echo_error__109_v0 "${__AF_env_var_get91_v0__63_26}" 1;
        __AF_echo_error109_v0__63_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__63_9" > /dev/null 2>&1
else
        env_var_get__91_v0 "MSG_INSTALL_SUCCESS";
        __AS=$?;
        __AF_env_var_get91_v0__65_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__65_25}"
fi
    replace__0_v0 "${tpl}" "{installed_version}" "${installed_version}";
    __AF_replace0_v0__66_27="${__AF_replace0_v0}";
    replace__0_v0 "${__AF_replace0_v0__66_27}" "{bin_path}" "${bin_path}";
    __AF_replace0_v0__66_19="${__AF_replace0_v0}";
    local msg="${__AF_replace0_v0__66_19}"
    echo_success__107_v0 "${msg}";
    __AF_echo_success107_v0__67_9="$__AF_echo_success107_v0";
    echo "$__AF_echo_success107_v0__67_9" > /dev/null 2>&1
    # Step 6: Create a civilized alias
    local civil_path="${bin_dir}""/""${civil_name}"
    file_exists__33_v0 "${civil_path}";
    __AF_file_exists33_v0__70_16="$__AF_file_exists33_v0";
    if [ $(echo  '!' "$__AF_file_exists33_v0__70_16" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_CIVIL_ALIAS_CREATING";
        __AS=$?;
        __AF_env_var_get91_v0__71_35="${__AF_env_var_get91_v0}";
        local tpl_alias="${__AF_env_var_get91_v0__71_35}"
        replace__0_v0 "${tpl_alias}" "{civil_name}" "${civil_name}";
        __AF_replace0_v0__72_29="${__AF_replace0_v0}";
        local msg_alias="${__AF_replace0_v0__72_29}"
        echo_info__106_v0 "${msg_alias}";
        __AF_echo_info106_v0__73_13="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__73_13" > /dev/null 2>&1
         ln -s "${bin_path}" "${civil_path}" ;
        __AS=$?;
if [ $__AS != 0 ]; then
            env_var_get__91_v0 "MSG_CIVIL_ALIAS_FAILED";
            __AS=$?;
            __AF_env_var_get91_v0__75_44="${__AF_env_var_get91_v0}";
            local tpl_alias_fail="${__AF_env_var_get91_v0__75_44}"
            replace__0_v0 "${tpl_alias_fail}" "{civil_name}" "${civil_name}";
            __AF_replace0_v0__76_54="${__AF_replace0_v0}";
            replace__0_v0 "${__AF_replace0_v0__76_54}" "{bin_path}" "${bin_path}";
            __AF_replace0_v0__76_46="${__AF_replace0_v0}";
            replace__0_v0 "${__AF_replace0_v0__76_46}" "{civil_path}" "${civil_path}";
            __AF_replace0_v0__76_38="${__AF_replace0_v0}";
            local msg_alias_fail="${__AF_replace0_v0__76_38}"
            echo_warning__108_v0 "${msg_alias_fail}";
            __AF_echo_warning108_v0__77_17="$__AF_echo_warning108_v0";
            echo "$__AF_echo_warning108_v0__77_17" > /dev/null 2>&1
fi
fi
    # Step7: Warn if bin_dir is not in PATH
    split__3_v0 "${path_env}" ":";
    __AF_split3_v0__81_46=("${__AF_split3_v0[@]}");
    array_contains__121_v0 __AF_split3_v0__81_46[@] "${bin_dir}";
    __AF_array_contains121_v0__81_31="$__AF_array_contains121_v0";
    if [ $(echo $([ "_${path_env}" == "_" ]; echo $?) '&&' $(echo  '!' "$__AF_array_contains121_v0__81_31" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_WARN_NOT_IN_PATH";
        __AS=$?;
        __AF_env_var_get91_v0__82_25="${__AF_env_var_get91_v0}";
        __8_tpl="${__AF_env_var_get91_v0__82_25}"
        replace__0_v0 "${__8_tpl}" "{bin_dir}" "${bin_dir}";
        __AF_replace0_v0__83_19="${__AF_replace0_v0}";
        __9_msg="${__AF_replace0_v0__83_19}"
        echo_warning__108_v0 "${__9_msg}";
        __AF_echo_warning108_v0__84_9="$__AF_echo_warning108_v0";
        echo "$__AF_echo_warning108_v0__84_9" > /dev/null 2>&1
        echo_info__106_v0 "You can add the following line to your shell profile (e.g., ~/.bashrc, ~/.zshrc):";
        __AF_echo_info106_v0__85_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__85_9" > /dev/null 2>&1
        echo_info__106_v0 "export PATH=\$PATH:${bin_dir}";
        __AF_echo_info106_v0__86_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__86_9" > /dev/null 2>&1
fi
}
uninstall__209_v0() {
    local home_dir=$1
    local name=$2
    if [ $([ "_${home_dir}" != "_" ]; echo $?) != 0 ]; then
        env_var_get__91_v0 "MSG_ERR_NO_HOME";
        __AS=$?;
        __AF_env_var_get91_v0__92_26="${__AF_env_var_get91_v0}";
        echo_error__109_v0 "${__AF_env_var_get91_v0__92_26}" 1;
        __AF_echo_error109_v0__92_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__92_9" > /dev/null 2>&1
        exit 1
fi
    local bin_dir="${home_dir}""/.local/bin"
    local bin_path="${bin_dir}""/""${name}"
    local config_dir="${home_dir}""/.fuckit"
    file_exists__33_v0 "${bin_path}";
    __AF_file_exists33_v0__100_12="$__AF_file_exists33_v0";
    if [ $(echo  '!' "$__AF_file_exists33_v0__100_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_var_get__91_v0 "MSG_UNINSTALL_NOT_INSTALLED";
        __AS=$?;
        __AF_env_var_get91_v0__101_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__101_25}"
        # Need to add this key
        replace__0_v0 "${tpl}" "{bin_path}" "${bin_path}";
        __AF_replace0_v0__102_19="${__AF_replace0_v0}";
        local msg="${__AF_replace0_v0__102_19}"
        echo_warning__108_v0 "${msg}";
        __AF_echo_warning108_v0__103_9="$__AF_echo_warning108_v0";
        echo "$__AF_echo_warning108_v0__103_9" > /dev/null 2>&1
        exit 0
fi
    env_var_get__91_v0 "MSG_UNINSTALL_START";
    __AS=$?;
    __AF_env_var_get91_v0__107_21="${__AF_env_var_get91_v0}";
    echo_info__106_v0 "${__AF_env_var_get91_v0__107_21}";
    __AF_echo_info106_v0__107_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__107_5" > /dev/null 2>&1
    # Find and remove all symbolic links (personas/aliases)
    env_var_get__91_v0 "MSG_UNINSTALL_SEARCHING_ALIASES";
    __AS=$?;
    __AF_env_var_get91_v0__110_28="${__AF_env_var_get91_v0}";
    local tpl_search="${__AF_env_var_get91_v0__110_28}"
    replace__0_v0 "${tpl_search}" "{bin_dir}" "${bin_dir}";
    __AF_replace0_v0__111_15="${__AF_replace0_v0}";
    echo_info__106_v0 "${__AF_replace0_v0__111_15}";
    __AF_echo_info106_v0__111_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__111_5" > /dev/null 2>&1
    __AMBER_VAL_18=$( find "${bin_dir}" -type l -lname "*/${name}" );
    __AS=$?;
    local aliases="${__AMBER_VAL_18}"
    if [ $([ "_${aliases}" == "_" ]; echo $?) != 0 ]; then
        while IFS= read -r alias_path; do
            env_var_get__91_v0 "MSG_UNINSTALL_REMOVE_ALIAS";
            __AS=$?;
            __AF_env_var_get91_v0__115_29="${__AF_env_var_get91_v0}";
            local tpl="${__AF_env_var_get91_v0__115_29}"
            replace__0_v0 "${tpl}" "{alias_path}" "${alias_path}";
            __AF_replace0_v0__116_23="${__AF_replace0_v0}";
            echo_info__106_v0 "${__AF_replace0_v0__116_23}";
            __AF_echo_info106_v0__116_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__116_13" > /dev/null 2>&1
             rm "${alias_path}" ;
            __AS=$?;
if [ $__AS != 0 ]; then
                env_var_get__91_v0 "MSG_UNINSTALL_ERR_REMOVE_ALIAS";
                __AS=$?;
                __AF_env_var_get91_v0__118_38="${__AF_env_var_get91_v0}";
                local tpl_fail="${__AF_env_var_get91_v0__118_38}"
                # Need to add this key
                replace__0_v0 "${tpl_fail}" "{alias_path}" "${alias_path}";
                __AF_replace0_v0__119_30="${__AF_replace0_v0}";
                echo_warning__108_v0 "${__AF_replace0_v0__119_30}";
                __AF_echo_warning108_v0__119_17="$__AF_echo_warning108_v0";
                echo "$__AF_echo_warning108_v0__119_17" > /dev/null 2>&1
fi
done <"${aliases}"
else
        env_var_get__91_v0 "MSG_UNINSTALL_NO_ALIASES";
        __AS=$?;
        __AF_env_var_get91_v0__123_25="${__AF_env_var_get91_v0}";
        echo_info__106_v0 "${__AF_env_var_get91_v0__123_25}";
        __AF_echo_info106_v0__123_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__123_9" > /dev/null 2>&1
fi
    # Remove the main executable
    env_var_get__91_v0 "MSG_UNINSTALL_REMOVE_EXEC";
    __AS=$?;
    __AF_env_var_get91_v0__127_29="${__AF_env_var_get91_v0}";
    local tpl_rm_exec="${__AF_env_var_get91_v0__127_29}"
    replace__0_v0 "${tpl_rm_exec}" "{bin_path}" "${bin_path}";
    __AF_replace0_v0__128_15="${__AF_replace0_v0}";
    echo_info__106_v0 "${__AF_replace0_v0__128_15}";
    __AF_echo_info106_v0__128_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__128_5" > /dev/null 2>&1
     rm "${bin_path}" ;
    __AS=$?;
if [ $__AS != 0 ]; then
        env_var_get__91_v0 "MSG_UNINSTALL_ERR_REMOVE_EXEC";
        __AS=$?;
        __AF_env_var_get91_v0__130_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__130_25}"
        # Need to add this key
        replace__0_v0 "${tpl}" "{bin_path}" "${bin_path}";
        __AF_replace0_v0__131_20="${__AF_replace0_v0}";
        echo_error__109_v0 "${__AF_replace0_v0__131_20}" 1;
        __AF_echo_error109_v0__131_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__131_9" > /dev/null 2>&1
        exit 1
fi
    # Ask to remove the configuration directory
    dir_exists__32_v0 "${config_dir}";
    __AF_dir_exists32_v0__136_8="$__AF_dir_exists32_v0";
    if [ "$__AF_dir_exists32_v0__136_8" != 0 ]; then
        env_var_get__91_v0 "MSG_UNINSTALL_CONFIRM_RM_CONFIG";
        __AS=$?;
        __AF_env_var_get91_v0__137_25="${__AF_env_var_get91_v0}";
        local tpl="${__AF_env_var_get91_v0__137_25}"
        replace__0_v0 "${tpl}" "{config_dir}" "${config_dir}";
        __AF_replace0_v0__138_26="${__AF_replace0_v0}";
        input_confirm__96_v0 "${__AF_replace0_v0__138_26}" 0;
        __AF_input_confirm96_v0__138_12="$__AF_input_confirm96_v0";
        if [ "$__AF_input_confirm96_v0__138_12" != 0 ]; then
            env_var_get__91_v0 "MSG_UNINSTALL_RM_CONFIG_DIR";
            __AS=$?;
            __AF_env_var_get91_v0__139_36="${__AF_env_var_get91_v0}";
            local tpl_rm_dir="${__AF_env_var_get91_v0__139_36}"
            replace__0_v0 "${tpl_rm_dir}" "{config_dir}" "${config_dir}";
            __AF_replace0_v0__140_23="${__AF_replace0_v0}";
            echo_info__106_v0 "${__AF_replace0_v0__140_23}";
            __AF_echo_info106_v0__140_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__140_13" > /dev/null 2>&1
             rm -r "${config_dir}" ;
            __AS=$?;
if [ $__AS != 0 ]; then
                env_var_get__91_v0 "MSG_UNINSTALL_ERR_RM_CONFIG";
                __AS=$?;
                __AF_env_var_get91_v0__142_38="${__AF_env_var_get91_v0}";
                local tpl_fail="${__AF_env_var_get91_v0__142_38}"
                # Need to add this key
                replace__0_v0 "${tpl_fail}" "{config_dir}" "${config_dir}";
                __AF_replace0_v0__143_28="${__AF_replace0_v0}";
                echo_error__109_v0 "${__AF_replace0_v0__143_28}" 1;
                __AF_echo_error109_v0__143_17="$__AF_echo_error109_v0";
                echo "$__AF_echo_error109_v0__143_17" > /dev/null 2>&1
                exit 1
fi
else
            env_var_get__91_v0 "MSG_UNINSTALL_KEEP_CONFIG_DIR";
            __AS=$?;
            __AF_env_var_get91_v0__147_34="${__AF_env_var_get91_v0}";
            local tpl_keep="${__AF_env_var_get91_v0__147_34}"
            replace__0_v0 "${tpl_keep}" "{config_dir}" "${config_dir}";
            __AF_replace0_v0__148_23="${__AF_replace0_v0}";
            echo_info__106_v0 "${__AF_replace0_v0__148_23}";
            __AF_echo_info106_v0__148_13="$__AF_echo_info106_v0";
            echo "$__AF_echo_info106_v0__148_13" > /dev/null 2>&1
fi
fi
    env_var_get__91_v0 "MSG_UNINSTALL_SUCCESS";
    __AS=$?;
    __AF_env_var_get91_v0__152_24="${__AF_env_var_get91_v0}";
    echo_success__107_v0 "${__AF_env_var_get91_v0__152_24}";
    __AF_echo_success107_v0__152_5="$__AF_echo_success107_v0";
    echo "$__AF_echo_success107_v0__152_5" > /dev/null 2>&1
}
compare_versions__230_v0() {
    local v1=$1
    local v2=$2
    split__3_v0 "${v1}" ".";
    __AF_split3_v0__4_18=("${__AF_split3_v0[@]}");
    local parts1=("${__AF_split3_v0__4_18[@]}")
    split__3_v0 "${v2}" ".";
    __AF_split3_v0__5_18=("${__AF_split3_v0[@]}");
    local parts2=("${__AF_split3_v0__5_18[@]}")
    local len1="${#parts1[@]}"
    local len2="${#parts2[@]}"
    local max_len=$(if [ $(echo ${len1} '>' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo ${len1}; else echo ${len2}; fi)
    for i in $(seq 0 $(echo ${max_len} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        # If part is missing, treat it as 0
        parse_number__12_v0 "${parts1[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions230_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__14_34="$__AF_parse_number12_v0";
        local num1=$(if [ $(echo ${i} '<' ${len1} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__14_34"; else echo 0; fi)
        parse_number__12_v0 "${parts2[${i}]}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_compare_versions230_v0=''
return $__AS
fi;
        __AF_parse_number12_v0__15_34="$__AF_parse_number12_v0";
        local num2=$(if [ $(echo ${i} '<' ${len2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "$__AF_parse_number12_v0__15_34"; else echo 0; fi)
        if [ $(echo ${num1} '>' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions230_v0=1;
            return 0
fi
        if [ $(echo ${num1} '<' ${num2} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_compare_versions230_v0=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            return 0
fi
done
    __AF_compare_versions230_v0=0;
    return 0
}
get_python_info__236_v0() {
    __AMBER_ARRAY_19=("python3" "python" "py" "python2");
    local python_commands=("${__AMBER_ARRAY_19[@]}")
    __AMBER_ARRAY_20=();
    local available_pythons=("${__AMBER_ARRAY_20[@]}")
    for cmd in "${python_commands[@]}"; do
        is_command__93_v0 "${cmd}";
        __AF_is_command93_v0__60_12="$__AF_is_command93_v0";
        if [ "$__AF_is_command93_v0__60_12" != 0 ]; then
            __AMBER_VAL_21=$( ${cmd} --version 2>&1 );
            __AS=$?;
            local version_output="${__AMBER_VAL_21}"
            __AMBER_VAL_22=$( echo "${version_output}" | tr -d '
' | sed 's/^.* //' );
            __AS=$?;
            local version="${__AMBER_VAL_22}"
            __AMBER_ARRAY_23=("${cmd} ${version}");
            available_pythons+=("${__AMBER_ARRAY_23[@]}")
fi
done
    __AF_get_python_info236_v0=("${available_pythons[@]}");
    return 0
}
execute_python3_script__237_v0() {
    local script=$1
    local args=("${!2}")
    get_python_info__236_v0 ;
    __AF_get_python_info236_v0__70_29=("${__AF_get_python_info236_v0[@]}");
    local available_pythons=("${__AF_get_python_info236_v0__70_29[@]}")
    if [ $(echo "${#available_pythons[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_execute_python3_script237_v0='';
        return 1
fi
    split__3_v0 "${available_pythons[0]}" " ";
    __AF_split3_v0__72_30=("${__AF_split3_v0[@]}");
    local python_cmd_version=("${__AF_split3_v0__72_30[@]}")
    local python_cmd="${python_cmd_version[0]}"
    local python_version="${python_cmd_version[1]}"
    # Check if Python version is at least 3.6
    compare_versions__230_v0 "${python_version}" "3.6";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_execute_python3_script237_v0=''
return $__AS
fi;
    __AF_compare_versions230_v0__76_8="$__AF_compare_versions230_v0";
    if [ $(echo "$__AF_compare_versions230_v0__76_8" '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_execute_python3_script237_v0='';
        return 1
fi
    replace__0_v0 "${script}" "'" "'\\''";
    __AF_replace0_v0__77_26="${__AF_replace0_v0}";
    local escaped_script="${__AF_replace0_v0__77_26}"
    local full_command="${python_cmd} -c '${escaped_script}'"
    for arg in "${args[@]}"; do
        # Safely quote each argument
        __AMBER_VAL_24=$( printf "%q" "${arg}" );
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_execute_python3_script237_v0=''
return $__AS
fi;
        local quoted_arg="${__AMBER_VAL_24}"
        full_command+=" ${quoted_arg}"
done
    __AMBER_VAL_25=$( sh -c "${full_command}" );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_execute_python3_script237_v0=''
return $__AS
fi;
    __AF_execute_python3_script237_v0="${__AMBER_VAL_25}";
    return 0
}
safe_escape_json_jq__241_v0() {
    local text=$1
    __AMBER_VAL_26=$( jq -rn --arg s "${text}" '$s | @json' );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_safe_escape_json_jq241_v0=''
return $__AS
fi;
    __AF_safe_escape_json_jq241_v0="${__AMBER_VAL_26}";
    return 0
    # already enclosed in quotes
}
safe_escape_json_fallback__242_v0() {
    local text=$1
    if [ $([ "_${text}" != "_" ]; echo $?) != 0 ]; then
        __AF_safe_escape_json_fallback242_v0="\"\"";
        return 0
fi
    split_chars__13_v0 "${text}";
    __AF_split_chars13_v0__13_17=("${__AF_split_chars13_v0[@]}");
    local chars=("${__AF_split_chars13_v0__13_17[@]}")
    local escaped_text=""
    for char in "${chars[@]}"; do
        if [ $([ "_${char}" != "_\"" ]; echo $?) != 0 ]; then
            escaped_text+="\\\""
elif [ $([ "_${char}" != "_\\" ]; echo $?) != 0 ]; then
            escaped_text+="\\\\"
elif [ $([ "_${char}" != "_
" ]; echo $?) != 0 ]; then
            escaped_text+="\\n"
else
            escaped_text+="${char}"
fi
done
    __AF_safe_escape_json_fallback242_v0="\"${escaped_text}\"";
    return 0
}
extract_json_value_jq__243_v0() {
    local json_text=$1
    local path=$2
    __AMBER_VAL_27=$( jq -rn --argjson j "${json_text}" --arg p "${path}" '$j | getpath($p | split(".") | map(tonumber? // .))' );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value_jq243_v0=''
return $__AS
fi;
    __AF_extract_json_value_jq243_v0="${__AMBER_VAL_27}";
    return 0
}
safe_escape_json_py__244_v0() {
    local text=$1
    local script="import json,sys;print(json.dumps(sys.argv[1] if len(sys.argv) > 1 else ''))"
    __AMBER_ARRAY_28=("${text}");
    execute_python3_script__237_v0 "${script}" __AMBER_ARRAY_28[@];
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_safe_escape_json_py244_v0=''
return $__AS
fi;
    __AF_execute_python3_script237_v0__36_12="${__AF_execute_python3_script237_v0}";
    __AF_safe_escape_json_py244_v0="${__AF_execute_python3_script237_v0__36_12}";
    return 0
}
extract_json_value_py__245_v0() {
    local json_text=$1
    local path=$2
    local script="import json,sys;d=json.loads(sys.argv[1]);p=sys.argv[2].split('.');v=d;
try:
    for k in p: v=v[int(k) if k.isdigit() and isinstance(v, list) else k]
    print(json.dumps(v) if isinstance(v,(dict,list)) else v)
except:print('null')"
    __AMBER_ARRAY_29=("${json_text}" "${path}");
    execute_python3_script__237_v0 "${script}" __AMBER_ARRAY_29[@];
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value_py245_v0=''
return $__AS
fi;
    __AF_execute_python3_script237_v0__45_12="${__AF_execute_python3_script237_v0}";
    __AF_extract_json_value_py245_v0="${__AF_execute_python3_script237_v0__45_12}";
    return 0
}
raw_unescape_json_value__246_v0() {
    local text=$1
    split_chars__13_v0 "${text}";
    __AF_split_chars13_v0__49_17=("${__AF_split_chars13_v0[@]}");
    local chars=("${__AF_split_chars13_v0__49_17[@]}")
    local unescaped_text=""
    local i=0
    local text_len="${#chars[@]}"
    while :
do
        if [ $(echo ${i} '>=' ${text_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            break
fi
        local char="${chars[${i}]}"
        if [ $([ "_${char}" != "_\\" ]; echo $?) != 0 ]; then
            if [ $(echo $(echo ${i} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '<' ${text_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                local next_char="${chars[$(echo ${i} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}"
                if [ $([ "_${next_char}" != "_\\" ]; echo $?) != 0 ]; then
                    unescaped_text+="\\"
elif [ $([ "_${next_char}" != "_\"" ]; echo $?) != 0 ]; then
                    unescaped_text+="\""
elif [ $([ "_${next_char}" != "_n" ]; echo $?) != 0 ]; then
                    unescaped_text+="
"
else
                    unescaped_text+="${char}"
                    unescaped_text+="${next_char}"
fi
                i=$(echo ${i} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                unescaped_text+="${char}"
                i=$(echo ${i} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
            unescaped_text+="${char}"
            i=$(echo ${i} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
done
    __AF_raw_unescape_json_value246_v0="${unescaped_text}";
    return 0
}
extract_json_value_sed_fallback__247_v0() {
    local json_text=$1
    local path=$2
    __AMBER_VAL_30=$( awk -F. '{print $NF}' <<< "${path}" );
    __AS=$?;
    local key="${__AMBER_VAL_30}"
    __AMBER_VAL_31=$( tr -d '
' <<< "${json_text}" | sed -E -n 's/.*"'${key}'"[[:space:]]*:[[:space:]]*"(([^"]|\\")*)".*/\1/p' );
    __AS=$?;
    local value="${__AMBER_VAL_31}"
    if [ $([ "_${value}" != "_" ]; echo $?) != 0 ]; then
        __AF_extract_json_value_sed_fallback247_v0='';
        return 1
fi
    __AF_extract_json_value_sed_fallback247_v0="${value}";
    return 0
}
safe_escape_json__248_v0() {
    local text=$1
    is_command__93_v0 "jq";
    __AF_is_command93_v0__101_8="$__AF_is_command93_v0";
    if [ "$__AF_is_command93_v0__101_8" != 0 ]; then
        safe_escape_json_jq__241_v0 "${text}";
        __AS=$?;
if [ $__AS != 0 ]; then
            get_python_info__236_v0 ;
            __AF_get_python_info236_v0__103_20=("${__AF_get_python_info236_v0[@]}");
            if [ $(echo "${#__AF_get_python_info236_v0__103_20[@]}" '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                safe_escape_json_py__244_v0 "${text}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_safe_escape_json248_v0=''
return $__AS
fi;
                __AF_safe_escape_json_py244_v0__104_24="${__AF_safe_escape_json_py244_v0}";
                __AF_safe_escape_json248_v0="${__AF_safe_escape_json_py244_v0__104_24}";
                return 0
fi
            safe_escape_json_fallback__242_v0 "${text}";
            __AF_safe_escape_json_fallback242_v0__106_20="${__AF_safe_escape_json_fallback242_v0}";
            __AF_safe_escape_json248_v0="${__AF_safe_escape_json_fallback242_v0__106_20}";
            return 0
fi;
        __AF_safe_escape_json_jq241_v0__102_22="${__AF_safe_escape_json_jq241_v0}";
        local result="${__AF_safe_escape_json_jq241_v0__102_22}"
        __AF_safe_escape_json248_v0="${result}";
        return 0
fi
    get_python_info__236_v0 ;
    __AF_get_python_info236_v0__110_12=("${__AF_get_python_info236_v0[@]}");
    if [ $(echo "${#__AF_get_python_info236_v0__110_12[@]}" '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        safe_escape_json_py__244_v0 "${text}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_safe_escape_json248_v0=''
return $__AS
fi;
        __AF_safe_escape_json_py244_v0__111_16="${__AF_safe_escape_json_py244_v0}";
        __AF_safe_escape_json248_v0="${__AF_safe_escape_json_py244_v0__111_16}";
        return 0
fi
    safe_escape_json_fallback__242_v0 "${text}";
    __AF_safe_escape_json_fallback242_v0__113_12="${__AF_safe_escape_json_fallback242_v0}";
    __AF_safe_escape_json248_v0="${__AF_safe_escape_json_fallback242_v0__113_12}";
    return 0
}
extract_json_value__249_v0() {
    local json_text=$1
    local path=$2
    is_command__93_v0 "jq";
    __AF_is_command93_v0__117_8="$__AF_is_command93_v0";
    if [ "$__AF_is_command93_v0__117_8" != 0 ]; then
        extract_json_value_jq__243_v0 "${json_text}" "${path}";
        __AS=$?;
if [ $__AS != 0 ]; then
            get_python_info__236_v0 ;
            __AF_get_python_info236_v0__119_20=("${__AF_get_python_info236_v0[@]}");
            if [ $(echo "${#__AF_get_python_info236_v0__119_20[@]}" '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                extract_json_value_py__245_v0 "${json_text}" "${path}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value249_v0=''
return $__AS
fi;
                __AF_extract_json_value_py245_v0__120_24="${__AF_extract_json_value_py245_v0}";
                __AF_extract_json_value249_v0="${__AF_extract_json_value_py245_v0__120_24}";
                return 0
fi
            extract_json_value_sed_fallback__247_v0 "${json_text}" "${path}";
            __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value249_v0=''
return $__AS
fi;
            __AF_extract_json_value_sed_fallback247_v0__122_30="${__AF_extract_json_value_sed_fallback247_v0}";
            local sed_result="${__AF_extract_json_value_sed_fallback247_v0__122_30}"
            raw_unescape_json_value__246_v0 "${sed_result}";
            __AF_raw_unescape_json_value246_v0__123_20="${__AF_raw_unescape_json_value246_v0}";
            __AF_extract_json_value249_v0="${__AF_raw_unescape_json_value246_v0__123_20}";
            return 0
fi;
        __AF_extract_json_value_jq243_v0__118_22="${__AF_extract_json_value_jq243_v0}";
        local result="${__AF_extract_json_value_jq243_v0__118_22}"
        __AF_extract_json_value249_v0="${result}";
        return 0
fi
    get_python_info__236_v0 ;
    __AF_get_python_info236_v0__127_12=("${__AF_get_python_info236_v0[@]}");
    if [ $(echo "${#__AF_get_python_info236_v0__127_12[@]}" '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        extract_json_value_py__245_v0 "${json_text}" "${path}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value249_v0=''
return $__AS
fi;
        __AF_extract_json_value_py245_v0__128_16="${__AF_extract_json_value_py245_v0}";
        __AF_extract_json_value249_v0="${__AF_extract_json_value_py245_v0__128_16}";
        return 0
fi
    extract_json_value_sed_fallback__247_v0 "${json_text}" "${path}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_extract_json_value249_v0=''
return $__AS
fi;
    __AF_extract_json_value_sed_fallback247_v0__130_22="${__AF_extract_json_value_sed_fallback247_v0}";
    local sed_result="${__AF_extract_json_value_sed_fallback247_v0__130_22}"
    raw_unescape_json_value__246_v0 "${sed_result}";
    __AF_raw_unescape_json_value246_v0__131_12="${__AF_raw_unescape_json_value246_v0}";
    __AF_extract_json_value249_v0="${__AF_raw_unescape_json_value246_v0__131_12}";
    return 0
}
request_llm__252_v0() {
    local base_url=$1
    local model_name=$2
    local api_key=$3
    local system_prompt=$4
    local user_prompt=("${!5}")
    local assistant_prompt=("${!6}")
    slice__22_v0 "${base_url}" $(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') 0;
    __AF_slice22_v0__5_32="${__AF_slice22_v0}";
    local full_url="${base_url}chat/completions$(if [ $([ "_${__AF_slice22_v0__5_32}" != "_/" ]; echo $?) != 0 ]; then echo ""; else echo "/"; fi)"
    safe_escape_json__248_v0 "${system_prompt}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
    __AF_safe_escape_json248_v0__6_33="${__AF_safe_escape_json248_v0}";
    local escaped_system_prompt="${__AF_safe_escape_json248_v0__6_33}"
    local message_json="{\"role\": \"system\", \"content\": ${escaped_system_prompt}}"
    local user_len="${#user_prompt[@]}"
    local assistant_len="${#assistant_prompt[@]}"
    # Loop through the assistant prompts, which is the shorter or equal length array.
    if [ $(echo ${assistant_len} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        for i in $(seq 0 $(echo ${assistant_len} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            safe_escape_json__248_v0 "${user_prompt[${i}]}";
            __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
            __AF_safe_escape_json248_v0__15_32="${__AF_safe_escape_json248_v0}";
            local escaped_user="${__AF_safe_escape_json248_v0__15_32}"
            safe_escape_json__248_v0 "${assistant_prompt[${i}]}";
            __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
            __AF_safe_escape_json248_v0__16_37="${__AF_safe_escape_json248_v0}";
            local escaped_assistant="${__AF_safe_escape_json248_v0__16_37}"
            message_json+=", {\"role\": \"user\", \"content\": ${escaped_user}}"
            message_json+=", {\"role\": \"assistant\", \"content\": ${escaped_assistant}}"
done
fi
    # If there are remaining user prompts, add them.
    if [ $(echo ${user_len} '>' ${assistant_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        for j in $(seq ${assistant_len} $(echo ${user_len} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            safe_escape_json__248_v0 "${user_prompt[${j}]}";
            __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
            __AF_safe_escape_json248_v0__25_32="${__AF_safe_escape_json248_v0}";
            local escaped_user="${__AF_safe_escape_json248_v0__25_32}"
            message_json+=", {\"role\": \"user\", \"content\": ${escaped_user}}"
done
fi
    local payload="{
    \"model\": \"${model_name}\",
    \"messages\": [ ${message_json} ]
}"
    __AMBER_VAL_32=$(printf "%s" "${payload}" | curl -fsS "${full_url}" -H "Content-Type: application/json" -H "Authorization: Bearer ${api_key}" --data-binary @- );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
    local response="${__AMBER_VAL_32}"
    extract_json_value__249_v0 "${response}" "choices.0.message.content";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_request_llm252_v0=''
return $__AS
fi;
    __AF_extract_json_value249_v0__35_12="${__AF_extract_json_value249_v0}";
    __AF_request_llm252_v0="${__AF_extract_json_value249_v0__35_12}";
    return 0
}
get_package_managers__262_v0() {
    __AMBER_ARRAY_33=("apt" "yum" "dnf" "zypper" "pacman" "emerge" "apk" "brew" "pkg" "nix-env" "guix" "snap" "flatpak");
    local managers=("${__AMBER_ARRAY_33[@]}")
    __AMBER_ARRAY_34=();
    local available_managers=("${__AMBER_ARRAY_34[@]}")
    for manager in "${managers[@]}"; do
        is_command__93_v0 "${manager}";
        __AF_is_command93_v0__12_12="$__AF_is_command93_v0";
        if [ "$__AF_is_command93_v0__12_12" != 0 ]; then
            __AMBER_ARRAY_35=("${manager}");
            available_managers+=("${__AMBER_ARRAY_35[@]}")
fi
done
    __AF_get_package_managers262_v0=("${available_managers[@]}");
    return 0
}
get_shell_profiles__263_v0() {
    env_var_get__91_v0 "HOME";
    __AS=$?;
    __AF_env_var_get91_v0__20_35="${__AF_env_var_get91_v0}";
    local home_dir_from_env="${__AF_env_var_get91_v0__20_35}"
    __AMBER_VAL_36=$( echo ~ );
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    local home_dir=$(if [ $([ "_${home_dir_from_env}" != "_" ]; echo $?) != 0 ]; then echo "${__AMBER_VAL_36}"; else echo "${home_dir_from_env}"; fi)
    if [ $([ "_${home_dir}" != "_" ]; echo $?) != 0 ]; then
        __AMBER_ARRAY_37=();
        __AF_get_shell_profiles263_v0=("${__AMBER_ARRAY_37[@]}");
        return 0
fi
    __AMBER_ARRAY_38=("/.bashrc" "/.zshrc" "/.profile" "/.bash_profile" "/.config/fish/config.fish");
    local profiles=("${__AMBER_ARRAY_38[@]}")
    __AMBER_ARRAY_39=();
    local available_profiles=("${__AMBER_ARRAY_39[@]}")
    for profile in "${profiles[@]}"; do
        local full_path="${home_dir}""${profile}"
        file_exists__33_v0 "${full_path}";
        __AF_file_exists33_v0__32_12="$__AF_file_exists33_v0";
        if [ "$__AF_file_exists33_v0__32_12" != 0 ]; then
            __AMBER_ARRAY_40=("${full_path}");
            available_profiles+=("${__AMBER_ARRAY_40[@]}")
fi
done
    __AF_get_shell_profiles263_v0=("${available_profiles[@]}");
    return 0
}
get_os_info__264_v0() {
    local info=""
    is_command__93_v0 "sw_vers";
    __AF_is_command93_v0__41_8="$__AF_is_command93_v0";
    if [ "$__AF_is_command93_v0__41_8" != 0 ]; then
        __AMBER_VAL_41=$( sw_vers 2>/dev/null );
        __AS=$?;
        info+="${__AMBER_VAL_41}""
"
fi
    file_exists__33_v0 "/etc/os-release";
    __AF_file_exists33_v0__44_8="$__AF_file_exists33_v0";
    if [ "$__AF_file_exists33_v0__44_8" != 0 ]; then
        __AMBER_VAL_42=$( cat /etc/os-release 2>/dev/null );
        __AS=$?;
        info+="${__AMBER_VAL_42}""
"
fi
    __AMBER_VAL_43=$( uname -a 2>/dev/null );
    __AS=$?;
    info+="${__AMBER_VAL_43}"
    __AF_get_os_info264_v0="${info}";
    return 0
}
get_current_path__265_v0() {
    __AMBER_VAL_44=$( pwd );
    __AS=$?;
    __AF_get_current_path265_v0="${__AMBER_VAL_44}";
    return 0
}
get_python_info__266_v0() {
    __AMBER_ARRAY_45=("python3" "python" "py" "python2");
    local python_commands=("${__AMBER_ARRAY_45[@]}")
    __AMBER_ARRAY_46=();
    local available_pythons=("${__AMBER_ARRAY_46[@]}")
    for cmd in "${python_commands[@]}"; do
        is_command__93_v0 "${cmd}";
        __AF_is_command93_v0__60_12="$__AF_is_command93_v0";
        if [ "$__AF_is_command93_v0__60_12" != 0 ]; then
            __AMBER_VAL_47=$( ${cmd} --version 2>&1 );
            __AS=$?;
            local version_output="${__AMBER_VAL_47}"
            __AMBER_VAL_48=$( echo "${version_output}" | tr -d '
' | sed 's/^.* //' );
            __AS=$?;
            local version="${__AMBER_VAL_48}"
            __AMBER_ARRAY_49=("${cmd} ${version}");
            available_pythons+=("${__AMBER_ARRAY_49[@]}")
fi
done
    __AF_get_python_info266_v0=("${available_pythons[@]}");
    return 0
}
__6_URL="http://localhost:8787/"
get_persona_config_dir__277_v0() {
    env_var_get__91_v0 "HOME";
    __AS=$?;
    __AF_env_var_get91_v0__8_26="${__AF_env_var_get91_v0}";
    local home_dir="${__AF_env_var_get91_v0__8_26}"
    if [ $([ "_${home_dir}" != "_" ]; echo $?) != 0 ]; then
        __AF_get_persona_config_dir277_v0="";
        return 0
fi
    env_var_get__91_v0 "FUCKIT_PERSONA";
    __AS=$?;
    __AF_env_var_get91_v0__12_25="${__AF_env_var_get91_v0}";
    local persona="${__AF_env_var_get91_v0__12_25}"
    if [ $([ "_${persona}" != "_" ]; echo $?) != 0 ]; then
        # Default to 'fuck' if no persona is set
        persona="fuck"
fi
    __AF_get_persona_config_dir277_v0="${home_dir}/.fuckit/${persona}";
    return 0
}
llm_config__278_v0() {
    get_persona_config_dir__277_v0 ;
    __AF_get_persona_config_dir277_v0__21_22="${__AF_get_persona_config_dir277_v0}";
    local config_dir="${__AF_get_persona_config_dir277_v0__21_22}"
    env_var_get__91_v0 "FUCKIT_BASE_URL";
    __AS=$?;
    __AF_env_var_get91_v0__22_26="${__AF_env_var_get91_v0}";
    local base_url="${__AF_env_var_get91_v0__22_26}"
    env_var_get__91_v0 "FUCKIT_API_KEY";
    __AS=$?;
    __AF_env_var_get91_v0__23_25="${__AF_env_var_get91_v0}";
    local api_key="${__AF_env_var_get91_v0__23_25}"
    env_var_get__91_v0 "FUCKIT_MODEL_NAME";
    __AS=$?;
    __AF_env_var_get91_v0__24_28="${__AF_env_var_get91_v0}";
    local model_name="${__AF_env_var_get91_v0__24_28}"
    # Prioritize local config file if exists
    file_exists__33_v0 "${config_dir}/llm_config.env";
    __AF_file_exists33_v0__26_29="$__AF_file_exists33_v0";
    if [ $(echo $([ "_${config_dir}" == "_" ]; echo $?) '&&' "$__AF_file_exists33_v0__26_29" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        while IFS= read -r line; do
            split__3_v0 "${line}" "=";
            __AF_split3_v0__28_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__28_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                local key="${parts[0]}"
                local value="${parts[1]}"
                if [ $([ "_${key}" != "_FUCKIT_BASE_URL" ]; echo $?) != 0 ]; then
                    base_url="${value}"
elif [ $([ "_${key}" != "_FUCKIT_API_KEY" ]; echo $?) != 0 ]; then
                    api_key="${value}"
elif [ $([ "_${key}" != "_FUCKIT_MODEL_NAME" ]; echo $?) != 0 ]; then
                    model_name="${value}"
fi
fi
done <"${config_dir}/llm_config.env"
fi
    if [ $([ "_${base_url}" != "_" ]; echo $?) != 0 ]; then
        echo_warning__108_v0 "No Custom LLM Config Found"'!'" Using fuckit.sh Official LLM Endpoint.";
        __AF_echo_warning108_v0__47_9="$__AF_echo_warning108_v0";
        echo "$__AF_echo_warning108_v0__47_9" > /dev/null 2>&1
        base_url="${__6_URL}"
        api_key=""
        model_name="default"
fi
    __AMBER_ARRAY_50=("${base_url}" "${api_key}" "${model_name}");
    __AF_llm_config278_v0=("${__AMBER_ARRAY_50[@]}");
    return 0
}
get_custom_prompt__279_v0() {
    get_persona_config_dir__277_v0 ;
    __AF_get_persona_config_dir277_v0__56_22="${__AF_get_persona_config_dir277_v0}";
    local config_dir="${__AF_get_persona_config_dir277_v0__56_22}"
    file_exists__33_v0 "${config_dir}/custom_prompt.md";
    __AF_file_exists33_v0__57_29="$__AF_file_exists33_v0";
    if [ $(echo $([ "_${config_dir}" == "_" ]; echo $?) '&&' "$__AF_file_exists33_v0__57_29" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        file_read__34_v0 "${config_dir}/custom_prompt.md";
        __AS=$?;
        __AF_file_read34_v0__58_22="${__AF_file_read34_v0}";
        __AF_get_custom_prompt279_v0="${__AF_file_read34_v0__58_22}";
        return 0
fi
    __AF_get_custom_prompt279_v0="";
    return 0
}
get_memory__280_v0() {
    get_persona_config_dir__277_v0 ;
    __AF_get_persona_config_dir277_v0__64_22="${__AF_get_persona_config_dir277_v0}";
    local config_dir="${__AF_get_persona_config_dir277_v0__64_22}"
    file_exists__33_v0 "${config_dir}/memory.md";
    __AF_file_exists33_v0__65_29="$__AF_file_exists33_v0";
    if [ $(echo $([ "_${config_dir}" == "_" ]; echo $?) '&&' "$__AF_file_exists33_v0__65_29" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        file_read__34_v0 "${config_dir}/memory.md";
        __AS=$?;
        __AF_file_read34_v0__66_22="${__AF_file_read34_v0}";
        __AF_get_memory280_v0="${__AF_file_read34_v0__66_22}";
        return 0
fi
    __AF_get_memory280_v0="";
    return 0
}
get_core_prompt__283_v0() {
    get_package_managers__262_v0 ;
    __AF_get_package_managers262_v0__185_30=("${__AF_get_package_managers262_v0[@]}");
    get_shell_profiles__263_v0 ;
    __AF_get_shell_profiles263_v0__186_28=("${__AF_get_shell_profiles263_v0[@]}");
    get_os_info__264_v0 ;
    __AF_get_os_info264_v0__187_25="${__AF_get_os_info264_v0}";
    get_current_path__265_v0 ;
    __AF_get_current_path265_v0__188_24="${__AF_get_current_path265_v0}";
    local core_prompt="
You are a helpful command-line assistant behind the shell. You can only use shell command(s) to interact with user and the system. So you must respond with valid shell command(s) only, without any extra explanation or text.
IMPORTANT: When using the 'echo' command, you MUST use single quotes to enclose the string (e.g., echo 'Hello World'). This is a strict security requirement.
For example, if the user greets you, you can respond with:
echo 'Hello"'!'" How can I assist you today?'
If the user asks for help, for instance: \"find the largest file in current directory\", you can respond with:
find . -type f -exec du -sh {} + | sort -rh | head -n 1
If the task cannot be accomplished with single step, for example you need to know the files under a directory first, or you want to ask user for some questions, you can respond like this:
Example 1 (listing files):
ls -la /path/to/directory
Example 2 (asking user for input):
echo \"Please provide the filename you want to search for:\"
In this case, after the command(s) is excuted, or user answer your question, all histories and the commands' output plus user's answer will be sent back to you as context for next step.
Remember, you must only respond with valid shell command(s) without any extra text. Your entire response should be executable in a standard shell environment.
Actually, your response will be put into a sh file and using bash to execute it, so you can even use loop, conditionals, functions, etc.
Remember, by default, the process is multi-turn interaction. For example, the user says hi to you, and you respond echo hi, then user can continue to send message to you, with all contexts and previous commands' outputs.
But if you append a exit 201 at the end of your response, then there will be no further interaction, the process ends after executing your commands.
Another exit code is 202, this is to suggest user to end the session at their side.
A third exit code, 203, is for automatic continuation, which is crucial for complex tasks.

Here is your core working principle:
When a user's request is complex, ambiguous, or requires information you don't have (like file listings or file content), you MUST break it down into smaller, sequential steps. Use \`exit 203\` to chain these steps together. Your first step should almost always be an exploration command (e.g., \`ls -F\`, \`pwd\`, \`find . -maxdepth 2\`). The output will be fed back to you, allowing you to make an informed decision for the next step.

However, do not overcomplicate simple tasks. A critical rule is to **avoid using \`exit 201\` prematurely**. You should only use \`exit 201\` when the user explicitly signals the end of the conversation (e.g., with phrases like \"goodbye\", \"that's all\", \"thanks, bye\"). For all other tasks, including simple ones that can be answered with a single command, you must provide the answer and wait for the user's next instruction. Let the user decide when the session is over.

--- EXAMPLES ---

**Complex Task: \"Is this a FastAPI project?\"** (Requires exploration)

*   Your 1st response:
    \`\`\`
    ls -F
    exit 203
    \`\`\`
*   (System provides you the output of \`ls -F\`)
*   Your 2nd response (assuming you see \`requirements.txt\`):
    \`\`\`
    grep -q \"fastapi\" requirements.txt && echo \"This appears to be a FastAPI project.\" || echo \"FastAPI not found in requirements.txt.\"
    \`\`\`
    (Note: No \`exit 201\`. The task is complete, but you wait for the user's next move.)

**Simple Task: \"What is my username?\"** (Direct answer)

*   Your response:
    \`\`\`
    whoami
    \`\`\`
    (Note: No \`exit 201\`. You answered the question and now wait for the next instruction.)

**Heuristic Rule:** If you need to see the state of the filesystem or system to answer a question, your first response MUST be an exploration command followed by \`exit 203\`.

If you need multi-step commands to accomplish the task, you can respond with multiple commands, and do not append exit 201 or 202 at the end, so that user can continue to interact with you after executing your commands.
When you think you have accomplished the last step of the multi-step task, ask user if they need anything else. If user says no, then you can say goodbye (by responding echo goodbye) and append exit 202 at the end.
This case is like this:
...(multiple turns of interaction)...
You: echo 'Is there anything else I can help you with?'
User: No, that's all. Thank you"'!'"
You: 
echo 'Goodbye"'!'" Have a great day"'!'"'
exit 202
(User will get the suggestion to end the session)
In User's view, he will see:
Goodbye"'!'" Have a great day"'!'"
(Suggestion: You can end the session now. Ending(Y/N)?)
If user says Y, then the session ends. If user says N, then he can continue to chat with you.
For example, if user says N, then he can say:
User: Actually, I have another question.
You: echo \"Sure"'!'" What else can I help you with?\"
...(continue the interaction)...
If user wants to chat with you, do not append exit 201 or 202 at the end, so that user can continue to chat with you.
If user wants to end the session, you can say goodbye (by responding echo goodbye) and append exit 201 at the end.
If you want to suggest user to end the session, you can say goodbye (by responding echo goodbye) and append exit 202 at the end.

--- ALIAS (PERSONA) & LANGUAGE PACK MANAGEMENT ---
This script uses an i18n system. All user-facing messages are stored in shell variables like \`\$MSG_ALIAS_CREATING\`. When generating \`echo\` commands, you MUST use these variables instead of hardcoded strings.

**Creating an Alias:**
When a user asks to create an alias, for example, \"create an alias named 'ask'\", you MUST generate the following sequence of shell commands:

\`\`\`sh
NEW_ALIAS=\"ask\"
echo \"\$(eval echo \$MSG_ALIAS_CREATING)\"
# Step 1: Create the new persona's config directory
mkdir -p \"\$HOME/.fuckit/\$NEW_ALIAS\"
# Step 2: Copy the default configuration from the 'fuck' persona
cp -n \"\$HOME/.fuckit/fuck/llm_config.env\" \"\$HOME/.fuckit/\$NEW_ALIAS/\" 2>/dev/null || true
cp -n \"\$HOME/.fuckit/fuck/custom_prompt.md\" \"\$HOME/.fuckit/\$NEW_ALIAS/\" 2>/dev/null || true
cp -n \"\$HOME/.fuckit/fuck/memory.md\" \"\$HOME/.fuckit/\$NEW_ALIAS/\" 2>/dev/null || true
# Step 3: Create the symbolic link in the bin directory
ln -s \"\$HOME/.local/bin/fuck\" \"\$HOME/.local/bin/\$NEW_ALIAS\"
echo \"\$(eval echo \$MSG_ALIAS_CREATE_SUCCESS)\"
echo \"\$(eval echo \$MSG_ALIAS_CONFIG_PATH)\"
\`\`\`

**Deleting an Alias:**
When a user asks to delete an alias, for example, \"delete the 'ask' alias\", you MUST generate the following shell commands:

\`\`\`sh
ALIAS_TO_DELETE=\"ask\"
if [ \"\$ALIAS_TO_DELETE\" = \"fuck\" ]; then
    echo \"\$MSG_ERR_ALIAS_DELETE_DEFAULT\"
    exit 1
fi
echo \"\$(eval echo \$MSG_ALIAS_DELETING)\"
# Step 1: Remove the symbolic link
rm \"\$HOME/.local/bin/\$ALIAS_TO_DELETE\"
# Step 2: Remove the persona's config directory
rm -r \"\$HOME/.fuckit/\$ALIAS_TO_DELETE\"
echo \"\$(eval echo \$MSG_ALIAS_DELETE_SUCCESS)\"
\`\`\`

**Installing a Language Pack:**
When a user asks to install a language pack (e.g., \"install Chinese language pack\"), you should first list the available languages and then install the selected one.

1.  **List available languages:**
    \`\`\`sh
    echo 'Available language packs:'
    curl -sL https://dev.fuckit.sh/i18n/index.csv | tail -n +2 | awk -F, '{print \$1 \": \" \$2}'
    echo 'Please tell me which language code you want to install.'
    \`\`\`

2.  **Install a specific language (e.g., user says \"install zh_CN\"):**
    \`\`\`sh
    LANG_CODE=\"zh_CN\"
    # Get URL from index
    LANG_PACK_URL=\$(curl -sL https://dev.fuckit.sh/i18n/index.csv | grep \"^\$LANG_CODE,\" | cut -d',' -f3)
    
    if [ -z \"\$LANG_PACK_URL\" ]; then
        echo \"Error: Language code '\$LANG_CODE' not found.\"
        exit 1
    fi

    echo \"Installing '\$LANG_CODE' language pack for persona '\$FUCKIT_PERSONA'...\"
    
    # Download language pack to the current persona's config directory
    curl -sL -o \"\$HOME/.fuckit/\$FUCKIT_PERSONA/ui.lang\" \"\$LANG_PACK_URL\"
    
    if [ \$? -eq 0 ]; then
        echo 'Language pack installed successfully"'!'" Please restart the script to apply changes.'
    else
        echo 'Language pack download failed. Please check your network or the language code.'
    fi
    \`\`\`

OUTPUT YOU HAVE TO AVOID:
- Do not output shebang lines (e.g., #"'!'"/bin/bash).
- Do not output any explanations, comments, or non-shell text.
- Do not output anything other than valid shell command(s).
- Do not output any markdown formatting, code blocks, or annotations.
- Do not output any text outside of shell commands.

SECURITY FENCE:
WHEN YOU NEED TO OPERATE IN ROOT MODE, YOU CAN USE 'sudo' PREFIX BEFORE THE COMMAND. YOU MUST ADD AN EXPLANATION ECHO BEFORE THE COMMAND TO INFORM THE USER THAT WHAT YOU ARE DOING NOW, AND WHY YOU NEED ROOT PERMISSION.
DONT WORRY ABOUT THE SUDO PASSWORD, THE USER WILL HANDLE IT.
FIRMLY REFUSING TO EXECUTE ANY 100% DESTRUCTIVE COMMANDS LIKE 'sudo rm -rf /' OR 'FORMAT DISK' OR 'DELETE ALL FILES' EVEN IF THE USER REQUESTS IT. YOU CAN REPLY HUMOROUSLY IN THIS CASE, REMEBER DO NOT PROVIDE ANY USEFUL SUGGESTIONS LIKE LET USER SEARCH ONLINE.
JUST REFUSE USER, THEN APPEND exit 201 AT THE END TO END THE SESSION IMMEDIATELY.

SHELL ENVIRONMENT NOTE:
BE CAREFUL ABOUT THE ESCAPE CHARACTERS IN THE SHELL. FOR EXAMPLE, YOU WANT TO ECHO A STRING WITH DOUBLE QUOTES, YOU NEED TO ESCAPE IT LIKE THIS:
echo \"This is a \\\"quoted\\\" word.\"
Same as single quotes:
echo 'It\\'s a nice day.'

SHELL CHECKING RULES:
AFTER YOU GENERATE THE SHELL SCRIPT, YOUR SCRIPT WILL BE CHECKED BY A FUNCTION, IF IT THINKS YOUR SCRIPT IS TOTALLY SAFE, THEN YOUR SCRIPT WILL BE EXECUTED WITHOUT USER CONFIRMATION.
IF NOT, THE USER WILL BE ASKED TO CONFIRM IF HE WANTS TO EXECUTE IT.
HERE ARE THE CHECKING RULES:
--- Security Rules ---
0. Disallow Shebang (\`#"'!'"\`).
1. Allow empty lines (^\s*\$).
2. Allow comment lines (^\s*#).
3. Allow \`echo '...'\` (single quotes) format, supporting escaped quotes (').
4. Allow \`exit 201\`, \`exit 202\` and \`exit 203\`.

ENVIRONMENT AWARENESS:
You can be configured via files in \`~/.fuckit/\`:
- \`llm_config.env\`: Sets \`FUCKIT_BASE_URL\`, \`FUCKIT_API_KEY\`, \`FUCKIT_MODEL_NAME\`.
- \`custom_prompt.md\`: Appends custom instructions to this system prompt.
- \`memory.md\`: Provides you with long-term memory or context.

Avaliable Package Managers: ${__AF_get_package_managers262_v0__185_30[@]}
Avaliable Shell Profiles: ${__AF_get_shell_profiles263_v0__186_28[@]}
Operating System Info: ${__AF_get_os_info264_v0__187_25}
Current Working Path: ${__AF_get_current_path265_v0__188_24}
"
    get_custom_prompt__279_v0 ;
    __AF_get_custom_prompt279_v0__190_25="${__AF_get_custom_prompt279_v0}";
    local custom_prompt="${__AF_get_custom_prompt279_v0__190_25}"
    if [ $([ "_${custom_prompt}" == "_" ]; echo $?) != 0 ]; then
        core_prompt+="

--- CUSTOM PROMPT ---
""${custom_prompt}"
fi
    get_memory__280_v0 ;
    __AF_get_memory280_v0__194_18="${__AF_get_memory280_v0}";
    local memory="${__AF_get_memory280_v0__194_18}"
    if [ $([ "_${memory}" == "_" ]; echo $?) != 0 ]; then
        core_prompt+="

--- MEMORY ---
""${memory}"
fi
    __AF_get_core_prompt283_v0="${core_prompt}";
    return 0
}
get_python_tool_prompt__284_v0() {
    local python_cmd=$1
    local python_version=$2
    __AF_get_python_tool_prompt284_v0="
This system has installed Python interpreter: ${python_cmd}, version: ${python_version}.
If the task is complicated and out of the scope of shell scripts, you can use Python scripts to help you accomplish the task.
To use python, feel free to write like this in the shell script:
${python_cmd} << 'EOF'
# Your python code here
EOF
Remember to close the python code block with EOF.
Make sure the python code is indented properly if needed.
Always use here document (<< 'EOF' ... EOF) to embed python code in the shell script. Do not use -c option to pass code directly.
";
    return 0
}
custom_match_regex__291_v0() {
    local text=$1
    local pattern=$2
     printf "%s" "${text}" | grep -qE -- "${pattern}"  > /dev/null 2>&1;
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_custom_match_regex291_v0=0;
        return 0
fi
    __AF_custom_match_regex291_v0=1;
    return 0
}
# Checks the LLM output script file according to strict security rules.
# 
# --- Security Rules ---
# 0. Disallow Shebang (`#!`).
# 1. Allow empty lines (^\s*$).
# 2. Allow comment lines (^\s*#).
# 3. Allow `echo '...'` (single quotes) format, supporting escaped quotes (\').
# 4. Allow `exit 201`, `exit 202` and `exit 203`.
# --------------------
check_llm_output__292_v0() {
    local script_content=$1
    split_lines__4_v0 "${script_content}";
    __AF_split_lines4_v0__21_17=("${__AF_split_lines4_v0[@]}");
    local lines=("${__AF_split_lines4_v0__21_17[@]}")
    for line in "${lines[@]}"; do
        # Rule checks for set -o pipefail;
        trim__9_v0 "${line}";
        __AF_trim9_v0__25_12="${__AF_trim9_v0}";
        trim__9_v0 "${line}";
        __AF_trim9_v0__25_48="${__AF_trim9_v0}";
        trim__9_v0 "${line}";
        __AF_trim9_v0__25_75="${__AF_trim9_v0}";
        if [ $(echo $(echo $([ "_${__AF_trim9_v0__25_12}" != "_set -o pipefail;" ]; echo $?) '||' $([ "_${__AF_trim9_v0__25_48}" != "_set -e;" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${__AF_trim9_v0__25_75}" != "_set -e; set -o pipefail;" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            continue
fi
        # Rule 0: Disallow Shebang
        starts_with__20_v0 "${line}" "#"'!'"";
        __AF_starts_with20_v0__29_12="$__AF_starts_with20_v0";
        if [ "$__AF_starts_with20_v0__29_12" != 0 ]; then
            __AF_check_llm_output292_v0=0;
            return 0
fi
        # Step 1: Check for empty lines
        custom_match_regex__291_v0 "${line}" "^\s*\$";
        __AF_custom_match_regex291_v0__33_12="$__AF_custom_match_regex291_v0";
        if [ "$__AF_custom_match_regex291_v0__33_12" != 0 ]; then
            continue
fi
        # Step 2: Check for comment lines
        custom_match_regex__291_v0 "${line}" "^\s*#.*\$";
        __AF_custom_match_regex291_v0__37_12="$__AF_custom_match_regex291_v0";
        if [ "$__AF_custom_match_regex291_v0__37_12" != 0 ]; then
            continue
fi
        # Rule 3: Allow `echo '...'` by checking an ASCII-only version of the line.
        # Non-ASCII chars are replaced with spaces to preserve structure for the regex check,
        # which prevents both Unicode issues and command injection.
        __AMBER_VAL_51=$( printf "%s" "${line}" | tr -c '\11\12\15\40-\176' ' ' );
        __AS=$?;
        local sanitized_line="${__AMBER_VAL_51}"
        custom_match_regex__291_v0 "${sanitized_line}" "^\s*echo\s+'([^']|\\\\')*'\s*\$";
        __AF_custom_match_regex291_v0__44_12="$__AF_custom_match_regex291_v0";
        if [ "$__AF_custom_match_regex291_v0__44_12" != 0 ]; then
            continue
fi
        # Rule 4: Allow `exit 201`, `exit 202` and `exit 203`
        if [ $(echo $(echo $([ "_${line}" != "_exit 201" ]; echo $?) '||' $([ "_${line}" != "_exit 202" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${line}" != "_exit 203" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            continue
fi
        # If the code reaches here, the line does not match any known safe patterns.
        __AF_check_llm_output292_v0=0;
        return 0
done
    # All lines have passed the check.
    __AF_check_llm_output292_v0=1;
    return 0
}
start_chat_session__298_v0() {
    local initial_prompt=("${!1}")
    # Step 1: Load configuration
    llm_config__278_v0 ;
    __AF_llm_config278_v0__11_18=("${__AF_llm_config278_v0[@]}");
    local config=("${__AF_llm_config278_v0__11_18[@]}")
    local base_url="${config[0]}"
    local api_key="${config[1]}"
    local model_name="${config[2]}"
    if [ $([ "_${model_name}" != "_" ]; echo $?) != 0 ]; then
        env_var_get__91_v0 "MSG_ERR_LLM_MODEL_MISSING";
        __AS=$?;
        __AF_env_var_get91_v0__17_26="${__AF_env_var_get91_v0}";
        echo_error__109_v0 "${__AF_env_var_get91_v0__17_26}" 1;
        __AF_echo_error109_v0__17_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__17_9" > /dev/null 2>&1
        exit 1
fi
    # Step 2: Initialize histories and system prompt
    __AMBER_ARRAY_52=();
    local user_history=("${__AMBER_ARRAY_52[@]}")
    __AMBER_ARRAY_53=();
    local assistant_history=("${__AMBER_ARRAY_53[@]}")
    get_core_prompt__283_v0 ;
    __AF_get_core_prompt283_v0__24_25="${__AF_get_core_prompt283_v0}";
    local system_prompt="${__AF_get_core_prompt283_v0__24_25}"
    # Check for python and enhance prompt if available
    get_python_info__266_v0 ;
    __AF_get_python_info266_v0__27_23=("${__AF_get_python_info266_v0[@]}");
    local python_info=("${__AF_get_python_info266_v0__27_23[@]}")
    if [ $(echo "${#python_info[@]}" '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        split__3_v0 "${python_info[0]}" " ";
        __AF_split3_v0__29_30=("${__AF_split3_v0[@]}");
        local python_details=("${__AF_split3_v0__29_30[@]}")
        local python_cmd="${python_details[0]}"
        local python_version="${python_details[1]}"
        get_python_tool_prompt__284_v0 "${python_cmd}" "${python_version}";
        __AF_get_python_tool_prompt284_v0__32_26="${__AF_get_python_tool_prompt284_v0}";
        system_prompt+="${__AF_get_python_tool_prompt284_v0__32_26}"
fi
    # Step 3: Start the interactive chat loop
    local current_user_prompt="${initial_prompt[@]}"
    while :
do
        __AMBER_ARRAY_54=("${current_user_prompt}");
        user_history+=("${__AMBER_ARRAY_54[@]}")
        env_var_get__91_v0 "MSG_ASSISTANT_THINKING";
        __AS=$?;
        __AF_env_var_get91_v0__40_25="${__AF_env_var_get91_v0}";
        echo_info__106_v0 "${__AF_env_var_get91_v0__40_25}";
        __AF_echo_info106_v0__40_9="$__AF_echo_info106_v0";
        echo "$__AF_echo_info106_v0__40_9" > /dev/null 2>&1
        request_llm__252_v0 "${base_url}" "${model_name}" "${api_key}" "${system_prompt}" user_history[@] assistant_history[@];
        __AS=$?;
if [ $__AS != 0 ]; then
            env_var_get__91_v0 "MSG_ERR_LLM_FAILED";
            __AS=$?;
            __AF_env_var_get91_v0__42_32="${__AF_env_var_get91_v0}";
            echo_warning__108_v0 "${__AF_env_var_get91_v0__42_32}";
            __AF_echo_warning108_v0__42_13="$__AF_echo_warning108_v0";
            echo "$__AF_echo_warning108_v0__42_13" > /dev/null 2>&1
            # Ask user if they want to retry
            env_var_get__91_v0 "MSG_PROMPT_RETRY";
            __AS=$?;
            __AF_env_var_get91_v0__44_36="${__AF_env_var_get91_v0}";
            input_confirm__96_v0 "${__AF_env_var_get91_v0__44_36}" 1;
            __AF_input_confirm96_v0__44_16="$__AF_input_confirm96_v0";
            if [ "$__AF_input_confirm96_v0__44_16" != 0 ]; then
                # Remove the last failed prompt from history before retrying
                local __SLICE_UPPER_55=$(echo "${#user_history[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
                local __SLICE_OFFSET_56=0;
                __SLICE_OFFSET_56=$((__SLICE_OFFSET_56 > 0 ? __SLICE_OFFSET_56 : 0));
                local __SLICE_LENGTH_57=$(echo $(echo "${#user_history[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' $__SLICE_OFFSET_56 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
                __SLICE_LENGTH_57=$((__SLICE_LENGTH_57 > 0 ? __SLICE_LENGTH_57 : 0));
                user_history=("${user_history[@]:$__SLICE_OFFSET_56:$__SLICE_LENGTH_57}")
                continue
else
                exit 1
fi
fi;
        __AF_request_llm252_v0__41_34="${__AF_request_llm252_v0}";
        local assistant_response="${__AF_request_llm252_v0__41_34}"
        __AMBER_ARRAY_58=("${assistant_response}");
        assistant_history+=("${__AMBER_ARRAY_58[@]}")
        # Step 4: Security check and execution
        check_llm_output__292_v0 "${assistant_response}";
        __AF_check_llm_output292_v0__56_23="$__AF_check_llm_output292_v0";
        local is_safe="$__AF_check_llm_output292_v0__56_23"
        local should_execute=0
        if [ ${is_safe} != 0 ]; then
            should_execute=1
            env_var_get__91_v0 "MSG_SECURITY_CHECK_PASSED";
            __AS=$?;
            __AF_env_var_get91_v0__61_32="${__AF_env_var_get91_v0}";
            echo_success__107_v0 "${__AF_env_var_get91_v0__61_32}";
            __AF_echo_success107_v0__61_13="$__AF_echo_success107_v0";
            echo "$__AF_echo_success107_v0__61_13" > /dev/null 2>&1
else
            echo "${assistant_response}"
            env_var_get__91_v0 "MSG_SECURITY_CHECK_FAILED";
            __AS=$?;
            __AF_env_var_get91_v0__64_32="${__AF_env_var_get91_v0}";
            echo_warning__108_v0 "${__AF_env_var_get91_v0__64_32}";
            __AF_echo_warning108_v0__64_13="$__AF_echo_warning108_v0";
            echo "$__AF_echo_warning108_v0__64_13" > /dev/null 2>&1
            env_var_get__91_v0 "MSG_PROMPT_EXECUTE_ANYWAY";
            __AS=$?;
            __AF_env_var_get91_v0__65_50="${__AF_env_var_get91_v0}";
            input_confirm__96_v0 "${__AF_env_var_get91_v0__65_50}" 0;
            __AF_input_confirm96_v0__65_30="$__AF_input_confirm96_v0";
            should_execute="$__AF_input_confirm96_v0__65_30"
fi
        local scode=0
        local execution_context=""
        if [ ${should_execute} != 0 ]; then
            if [ $(echo  '!' ${is_safe} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                env_var_get__91_v0 "MSG_EXEC_COUNTDOWN";
                __AS=$?;
                __AF_env_var_get91_v0__71_33="${__AF_env_var_get91_v0}";
                echo_info__106_v0 "${__AF_env_var_get91_v0__71_33}";
                __AF_echo_info106_v0__71_17="$__AF_echo_info106_v0";
                echo "$__AF_echo_info106_v0__71_17" > /dev/null 2>&1
                 sleep 1 ;
                __AS=$?
fi
            scode=0
            __AMBER_VAL_59=$( set -o pipefail; bash -c "set -e; set -o pipefail;
${assistant_response}" 2>&1 | tee /dev/tty );
            __AS=$?;
if [ $__AS != 0 ]; then
                scode=$__AS
                if [ $(echo $__AS '==' 201 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    env_var_get__91_v0 "MSG_SESSION_ENDED_BY_ASSISTANT";
                    __AS=$?;
                    __AF_env_var_get91_v0__78_37="${__AF_env_var_get91_v0}";
                    echo_info__106_v0 "${__AF_env_var_get91_v0__78_37}";
                    __AF_echo_info106_v0__78_21="$__AF_echo_info106_v0";
                    echo "$__AF_echo_info106_v0__78_21" > /dev/null 2>&1
                    exit 0
fi
                if [ $(echo $__AS '==' 202 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    env_var_get__91_v0 "MSG_SESSION_SUGGEST_END";
                    __AS=$?;
                    __AF_env_var_get91_v0__82_37="${__AF_env_var_get91_v0}";
                    echo_info__106_v0 "${__AF_env_var_get91_v0__82_37}";
                    __AF_echo_info106_v0__82_21="$__AF_echo_info106_v0";
                    echo "$__AF_echo_info106_v0__82_21" > /dev/null 2>&1
                    env_var_get__91_v0 "MSG_PROMPT_END_SESSION";
                    __AS=$?;
                    __AF_env_var_get91_v0__83_44="${__AF_env_var_get91_v0}";
                    input_confirm__96_v0 "${__AF_env_var_get91_v0__83_44}" 1;
                    __AF_input_confirm96_v0__83_24="$__AF_input_confirm96_v0";
                    if [ "$__AF_input_confirm96_v0__83_24" != 0 ]; then
                        exit 0
fi
fi
                if [ $(echo $__AS '==' 203 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    env_var_get__91_v0 "MSG_ASSISTANT_CONTINUE";
                    __AS=$?;
                    __AF_env_var_get91_v0__88_37="${__AF_env_var_get91_v0}";
                    echo_info__106_v0 "${__AF_env_var_get91_v0__88_37}";
                    __AF_echo_info106_v0__88_21="$__AF_echo_info106_v0";
                    echo "$__AF_echo_info106_v0__88_21" > /dev/null 2>&1
                    # Skip user input and continue the loop
else
                    env_var_get__91_v0 "MSG_ERR_EXEC_FAILED";
                    __AS=$?;
                    __AF_env_var_get91_v0__91_37="${__AF_env_var_get91_v0}";
                    local tpl="${__AF_env_var_get91_v0__91_37}"
                    replace__0_v0 "${tpl}" "{status}" "$__AS";
                    __AF_replace0_v0__92_34="${__AF_replace0_v0}";
                    echo_warning__108_v0 "${__AF_replace0_v0__92_34}";
                    __AF_echo_warning108_v0__92_21="$__AF_echo_warning108_v0";
                    echo "$__AF_echo_warning108_v0__92_21" > /dev/null 2>&1
fi
fi;
            local output="${__AMBER_VAL_59}"
            if [ $(echo ${scode} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                env_var_get__91_v0 "MSG_EXEC_SUCCESS";
                __AS=$?;
                __AF_env_var_get91_v0__96_36="${__AF_env_var_get91_v0}";
                echo_success__107_v0 "${__AF_env_var_get91_v0__96_36}";
                __AF_echo_success107_v0__96_17="$__AF_echo_success107_v0";
                echo "$__AF_echo_success107_v0__96_17" > /dev/null 2>&1
fi
            if [ ${is_safe} != 0 ]; then
                env_var_get__91_v0 "MSG_CONTEXT_EXEC_SUCCESS";
                __AS=$?;
                __AF_env_var_get91_v0__98_43="${__AF_env_var_get91_v0}";
                execution_context="${__AF_env_var_get91_v0__98_43}"
else
                env_var_get__91_v0 "MSG_CONTEXT_EXEC_FAIL";
                __AS=$?;
                __AF_env_var_get91_v0__100_33="${__AF_env_var_get91_v0}";
                local tpl="${__AF_env_var_get91_v0__100_33}"
fi
            replace__0_v0 "${tpl}" "{scode}" "${scode}";
            __AF_replace0_v0__101_45="${__AF_replace0_v0}";
            replace__0_v0 "${__AF_replace0_v0__101_45}" "{output}" "${output}";
            __AF_replace0_v0__101_37="${__AF_replace0_v0}";
            execution_context="${__AF_replace0_v0__101_37}"
else
            env_var_get__91_v0 "MSG_EXEC_SKIPPED";
            __AS=$?;
            __AF_env_var_get91_v0__103_32="${__AF_env_var_get91_v0}";
            echo_warning__108_v0 "${__AF_env_var_get91_v0__103_32}";
            __AF_echo_warning108_v0__103_13="$__AF_echo_warning108_v0";
            echo "$__AF_echo_warning108_v0__103_13" > /dev/null 2>&1
            env_var_get__91_v0 "MSG_CONTEXT_EXEC_SKIPPED";
            __AS=$?;
            __AF_env_var_get91_v0__104_39="${__AF_env_var_get91_v0}";
            execution_context="${__AF_env_var_get91_v0__104_39}"
fi
        # Step 5: Get next user input or continue automatically
        if [ $(echo ${scode} '==' 203 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            current_user_prompt="${execution_context}

User's next instruction: [AUTO-CONTINUE]"
            continue
fi
        local next_user_input=""
        while :
do
            env_var_get__91_v0 "MSG_PROMPT_USER";
            __AS=$?;
            __AF_env_var_get91_v0__115_50="${__AF_env_var_get91_v0}";
            input_prompt__94_v0 "${__AF_env_var_get91_v0__115_50}";
            __AF_input_prompt94_v0__115_31="${__AF_input_prompt94_v0}";
            next_user_input="${__AF_input_prompt94_v0__115_31}"
            if [ $([ "_${next_user_input}" == "_" ]; echo $?) != 0 ]; then
                break
fi
done
        if [ $(echo $([ "_${next_user_input}" != "_exit" ]; echo $?) '||' $([ "_${next_user_input}" != "_quit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            break
fi
        current_user_prompt="${execution_context}

User's next instruction: ${next_user_input}"
done
    env_var_get__91_v0 "MSG_SESSION_ENDED_BY_USER";
    __AS=$?;
    __AF_env_var_get91_v0__125_21="${__AF_env_var_get91_v0}";
    echo_info__106_v0 "${__AF_env_var_get91_v0__125_21}";
    __AF_echo_info106_v0__125_5="$__AF_echo_info106_v0";
    echo "$__AF_echo_info106_v0__125_5" > /dev/null 2>&1
}
get_persona_config_dir__308_v0() {
    env_var_get__91_v0 "HOME";
    __AS=$?;
    __AF_env_var_get91_v0__6_26="${__AF_env_var_get91_v0}";
    local home_dir="${__AF_env_var_get91_v0__6_26}"
    if [ $([ "_${home_dir}" != "_" ]; echo $?) != 0 ]; then
        __AF_get_persona_config_dir308_v0="";
        return 0
fi
    env_var_get__91_v0 "FUCKIT_PERSONA";
    __AS=$?;
    __AF_env_var_get91_v0__10_25="${__AF_env_var_get91_v0}";
    local persona="${__AF_env_var_get91_v0__10_25}"
    if [ $([ "_${persona}" != "_" ]; echo $?) != 0 ]; then
        # Default to 'fuck' if no persona is set
        persona="fuck"
fi
    __AF_get_persona_config_dir308_v0="${home_dir}/.fuckit/${persona}";
    return 0
}
# init_i18n sets up the UI messages.
# It first sets the default English messages, then overrides them
# with a language pack from the persona's config directory if it exists.
init_i18n__309_v0() {
    # Set default English messages
    env_var_set__90_v0 "MSG_INSTALL_START" "fuckit.sh is not installed. Installing now...";
    __AS=$?;
    __AF_env_var_set90_v0__23_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__23_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_INSTALL_UPGRADE_AVAILABLE" "A new version ({version}) is available. Your current version is {current_version}. Upgrading...";
    __AS=$?;
    __AF_env_var_set90_v0__24_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__24_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_INSTALL_LATEST" "You are already using the latest version ({current_version}).";
    __AS=$?;
    __AF_env_var_set90_v0__25_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__25_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_NO_HOME" "Cannot determine home directory. Please ensure HOME environment variable is set.";
    __AS=$?;
    __AF_env_var_set90_v0__26_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__26_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_INSTALL_CREATE_DIR" "Directory '{bin_dir}' does not exist. Creating it...";
    __AS=$?;
    __AF_env_var_set90_v0__27_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__27_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_INSTALL_DOWNLOADING" "Downloading 'fuckit.sh' to '{bin_dir}'...(via {url})";
    __AS=$?;
    __AF_env_var_set90_v0__28_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__28_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_NO_DOWNLOADER" "No Avaliable CLI Tools Found, Need curl, wget or aria2c.";
    __AS=$?;
    __AF_env_var_set90_v0__29_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__29_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_CHMOD_FAILED" "Failed to set executable permission on '{bin_path}'.";
    __AS=$?;
    __AF_env_var_set90_v0__30_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__30_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_INSTALL_FAILED" "Installation failed: Unable to verify installation.";
    __AS=$?;
    __AF_env_var_set90_v0__31_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__31_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_INSTALL_SUCCESS" "fuckit.sh version {installed_version} installed successfully at '{bin_path}'"'!'"";
    __AS=$?;
    __AF_env_var_set90_v0__32_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__32_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_WARN_NOT_IN_PATH" "Warning: '{bin_dir}' is not in your PATH environment variable. You may need to add it manually to run 'fuckit.sh' easily.";
    __AS=$?;
    __AF_env_var_set90_v0__33_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__33_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_CIVIL_ALIAS_CREATING" "Creating a civilized alias '{civil_name}'...";
    __AS=$?;
    __AF_env_var_set90_v0__34_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__34_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_CIVIL_ALIAS_FAILED" "Failed to create alias '{civil_name}'. You can create it manually by running: ln -s {bin_path} {civil_path}";
    __AS=$?;
    __AF_env_var_set90_v0__35_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__35_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_START" "Starting uninstallation process...";
    __AS=$?;
    __AF_env_var_set90_v0__36_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__36_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_SEARCHING_ALIASES" "Searching for aliases in '{bin_dir}'...";
    __AS=$?;
    __AF_env_var_set90_v0__37_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__37_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_REMOVE_ALIAS" "  - Removing alias: {alias_path}";
    __AS=$?;
    __AF_env_var_set90_v0__38_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__38_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_NO_ALIASES" "No aliases found.";
    __AS=$?;
    __AF_env_var_set90_v0__39_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__39_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_REMOVE_EXEC" "Removing main executable: {bin_path}";
    __AS=$?;
    __AF_env_var_set90_v0__40_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__40_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_CONFIRM_RM_CONFIG" "Do you want to remove all configurations and data from '{config_dir}'?";
    __AS=$?;
    __AF_env_var_set90_v0__41_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__41_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_RM_CONFIG_DIR" "Removing configuration directory: {config_dir}";
    __AS=$?;
    __AF_env_var_set90_v0__42_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__42_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_KEEP_CONFIG_DIR" "Configuration directory '{config_dir}' was not removed.";
    __AS=$?;
    __AF_env_var_set90_v0__43_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__43_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_SUCCESS" "fuckit.sh has been successfully uninstalled.";
    __AS=$?;
    __AF_env_var_set90_v0__44_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__44_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_NOT_INSTALLED" "fuckit.sh is not installed at '{bin_path}', nothing to do.";
    __AS=$?;
    __AF_env_var_set90_v0__45_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__45_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_ERR_REMOVE_ALIAS" "    Could not remove alias '{alias_path}'. Please check permissions.";
    __AS=$?;
    __AF_env_var_set90_v0__46_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__46_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_ERR_REMOVE_EXEC" "Failed to remove '{bin_path}'. Please check permissions and try again.";
    __AS=$?;
    __AF_env_var_set90_v0__47_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__47_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_UNINSTALL_ERR_RM_CONFIG" "Failed to remove '{config_dir}'. Please check permissions.";
    __AS=$?;
    __AF_env_var_set90_v0__48_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__48_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_NO_ARGS" "Oops, no arguments provided"'!'" It should not happen. But it did. Please visit https://fuckit.sh and report this issue.";
    __AS=$?;
    __AF_env_var_set90_v0__49_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__49_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_LLM_CONFIG_MISSING" "LLM configuration is missing or invalid. Please set FUCKIT_BASE_URL and FUCKIT_API_KEY environment variables, or create a config file at ~/.fuckit/llm_config.env.";
    __AS=$?;
    __AF_env_var_set90_v0__50_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__50_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_LLM_MODEL_MISSING" "LLM model name is missing. Please set FUCKIT_MODEL_NAME environment variable or add it to your config file.";
    __AS=$?;
    __AF_env_var_set90_v0__51_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__51_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ASSISTANT_THINKING" "Assistant is thinking...";
    __AS=$?;
    __AF_env_var_set90_v0__52_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__52_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_LLM_FAILED" "Failed to get response from LLM. Please check your configuration and network.";
    __AS=$?;
    __AF_env_var_set90_v0__53_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__53_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_PROMPT_RETRY" "Do you want to retry?";
    __AS=$?;
    __AF_env_var_set90_v0__54_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__54_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_SECURITY_CHECK_PASSED" "The script passed the security check.";
    __AS=$?;
    __AF_env_var_set90_v0__55_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__55_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_SECURITY_CHECK_FAILED" "We cannot guarantee the safety of the above script. Please review it carefully.";
    __AS=$?;
    __AF_env_var_set90_v0__56_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__56_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_PROMPT_EXECUTE_ANYWAY" "Do you want to execute it anyway?";
    __AS=$?;
    __AF_env_var_set90_v0__57_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__57_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_EXEC_COUNTDOWN" "Executing in 1 second... Press Ctrl+C to cancel.";
    __AS=$?;
    __AF_env_var_set90_v0__58_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__58_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_SESSION_ENDED_BY_ASSISTANT" "Session ended by assistant because he thinks the task is complete.";
    __AS=$?;
    __AF_env_var_set90_v0__59_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__59_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_SESSION_SUGGEST_END" "Execution finished with suggestion to end the session.";
    __AS=$?;
    __AF_env_var_set90_v0__60_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__60_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_PROMPT_END_SESSION" "Assistant suggested ending the session. End now?";
    __AS=$?;
    __AF_env_var_set90_v0__61_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__61_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ASSISTANT_CONTINUE" "Assistant requested to continue without user input.";
    __AS=$?;
    __AF_env_var_set90_v0__62_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__62_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_EXEC_FAILED" "Script execution failed with status: {status}";
    __AS=$?;
    __AF_env_var_set90_v0__63_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__63_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_EXEC_SUCCESS" "Execution finished.";
    __AS=$?;
    __AF_env_var_set90_v0__64_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__64_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_CONTEXT_EXEC_SUCCESS" "Your echoed script executed successfully, user has seen the output.";
    __AS=$?;
    __AF_env_var_set90_v0__65_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__65_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_CONTEXT_EXEC_FAIL" "Script executed with exit code: {scode}.
Script Output:
---
{output}
---";
    __AS=$?;
    __AF_env_var_set90_v0__66_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__66_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_EXEC_SKIPPED" "Execution skipped by user.";
    __AS=$?;
    __AF_env_var_set90_v0__67_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__67_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_CONTEXT_EXEC_SKIPPED" "User chose not to execute the script.";
    __AS=$?;
    __AF_env_var_set90_v0__68_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__68_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_PROMPT_USER" "You: ";
    __AS=$?;
    __AF_env_var_set90_v0__69_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__69_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_SESSION_ENDED_BY_USER" "Session ended by user.";
    __AS=$?;
    __AF_env_var_set90_v0__70_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__70_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ALIAS_CREATING" "Creating alias: '{alias}'...";
    __AS=$?;
    __AF_env_var_set90_v0__71_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__71_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ALIAS_CREATE_SUCCESS" "Alias '{alias}' created successfully. You can now use it like any other command.";
    __AS=$?;
    __AF_env_var_set90_v0__72_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__72_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ALIAS_CONFIG_PATH" "Configuration files are located in ~/.fuckit/{alias}/";
    __AS=$?;
    __AF_env_var_set90_v0__73_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__73_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ERR_ALIAS_DELETE_DEFAULT" "Error: The default persona 'fuck' cannot be deleted.";
    __AS=$?;
    __AF_env_var_set90_v0__74_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__74_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ALIAS_DELETING" "Deleting alias: '{alias}'...";
    __AS=$?;
    __AF_env_var_set90_v0__75_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__75_11" > /dev/null 2>&1
    env_var_set__90_v0 "MSG_ALIAS_DELETE_SUCCESS" "Alias '{alias}' has been deleted.";
    __AS=$?;
    __AF_env_var_set90_v0__76_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__76_11" > /dev/null 2>&1
    # Check for a persona-specific language file and override the defaults.
    get_persona_config_dir__308_v0 ;
    __AF_get_persona_config_dir308_v0__79_22="${__AF_get_persona_config_dir308_v0}";
    local config_dir="${__AF_get_persona_config_dir308_v0__79_22}"
    if [ $([ "_${config_dir}" == "_" ]; echo $?) != 0 ]; then
        local lang_file="${config_dir}/ui.lang"
        file_exists__33_v0 "${lang_file}";
        __AF_file_exists33_v0__82_12="$__AF_file_exists33_v0";
        if [ "$__AF_file_exists33_v0__82_12" != 0 ]; then
            while IFS= read -r line; do
                # Skip comments and empty lines
                starts_with__20_v0 "${line}" "#";
                __AF_starts_with20_v0__85_24="$__AF_starts_with20_v0";
                if [ $(echo $(echo  '!' "$__AF_starts_with20_v0__85_24" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${line}" == "_" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    split__3_v0 "${line}" "=";
                    __AF_split3_v0__86_33=("${__AF_split3_v0[@]}");
                    local parts=("${__AF_split3_v0__86_33[@]}")
                    if [ $(echo "${#parts[@]}" '>=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                        local key="${parts[0]}"
                        # Re-join the rest of the parts in case the value contains '='
                        local __SLICE_UPPER_60="${#parts[@]}";
                        local __SLICE_OFFSET_61=1;
                        __SLICE_OFFSET_61=$((__SLICE_OFFSET_61 > 0 ? __SLICE_OFFSET_61 : 0));
                        local __SLICE_LENGTH_62=$(echo "${#parts[@]}" '-' $__SLICE_OFFSET_61 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
                        __SLICE_LENGTH_62=$((__SLICE_LENGTH_62 > 0 ? __SLICE_LENGTH_62 : 0));
                        join__6_v0 "${parts[@]:$__SLICE_OFFSET_61:$__SLICE_LENGTH_62}" "=";
                        __AF_join6_v0__90_37="${__AF_join6_v0}";
                        local value="${__AF_join6_v0__90_37}"
                        # Remove quotes from value
                        starts_with__20_v0 "${value}" "\"";
                        __AF_starts_with20_v0__92_28="$__AF_starts_with20_v0";
                        ends_with__21_v0 "${value}" "\"";
                        __AF_ends_with21_v0__92_57="$__AF_ends_with21_v0";
                        if [ $(echo "$__AF_starts_with20_v0__92_28" '&&' "$__AF_ends_with21_v0__92_57" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                            __AMBER_LEN="${value}";
                            slice__22_v0 "${value}" 1 $(echo "${#__AMBER_LEN}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
                            __AF_slice22_v0__93_37="${__AF_slice22_v0}";
                            value="${__AF_slice22_v0__93_37}"
fi
                        env_var_set__90_v0 "${key}" "${value}";
                        __AS=$?;
                        __AF_env_var_set90_v0__95_31="$__AF_env_var_set90_v0";
                        echo "$__AF_env_var_set90_v0__95_31" > /dev/null 2>&1
fi
fi
done <"${lang_file}"
fi
fi
}
__0_VERSION="0.1.0"
__1_LANG="en"
__2_NAME="fuck"
__3_NAME_CIVIL="ask"
# const URL = "https://dev.fuckit.sh"
__4_URL="http://localhost:8787"
__5_USAGE="

"
# Dependency Checks
# check bc
 command -v bc > /dev/null 2>&1 ;
__AS=$?;
if [ $__AS != 0 ]; then
     echo -e "\033[0;31mDependency check failed: 'bc' command not found. Please install 'bc' and try again.\033[0m" >&2 ;
    __AS=$?
     echo "  - Debian/Ubuntu: sudo apt-get install bc" >&2 ;
    __AS=$?
     echo "  - RedHat/CentOS: sudo yum install bc" >&2 ;
    __AS=$?
     echo "  - Fedora:        sudo dnf install bc" >&2 ;
    __AS=$?
     echo "  - Arch Linux:    sudo pacman -S bc" >&2 ;
    __AS=$?
     echo "  - openSUSE:      sudo zypper install bc" >&2 ;
    __AS=$?
     echo "  - Alpine:        apk add bc" >&2 ;
    __AS=$?
    exit 1
fi
# check curl
 command -v curl > /dev/null 2>&1 ;
__AS=$?;
if [ $__AS != 0 ]; then
     echo -e "\033[0;31mDependency check failed: 'curl' command not found. Please install 'curl' and try again.\033[0m" >&2 ;
    __AS=$?
     echo "  - Debian/Ubuntu: sudo apt-get install curl" >&2 ;
    __AS=$?
     echo "  - RedHat/CentOS: sudo yum install curl" >&2 ;
    __AS=$?
     echo "  - Fedora:        sudo dnf install curl" >&2 ;
    __AS=$?
     echo "  - Arch Linux:    sudo pacman -S curl" >&2 ;
    __AS=$?
     echo "  - openSUSE:      sudo zypper install curl" >&2 ;
    __AS=$?
     echo "  - Alpine:        apk add curl" >&2 ;
    __AS=$?
     echo "  - MacOS (Homebrew): brew install curl" >&2 ;
    __AS=$?
    exit 1
fi
# Get the home directory from environment variable
env_var_get__91_v0 "HOME";
__AS=$?;
__AF_env_var_get91_v0__46_22="${__AF_env_var_get91_v0}";
__7_home_dir="${__AF_env_var_get91_v0__46_22}"
if [ $([ "_${__7_home_dir}" != "_" ]; echo $?) != 0 ]; then
    echo_warning__108_v0 "HOME environment variable is not set. Try 'export HOME=~' and run again. Add to your shell profile to make it permanent.";
    __AF_echo_warning108_v0__48_5="$__AF_echo_warning108_v0";
    echo "$__AF_echo_warning108_v0__48_5" > /dev/null 2>&1
fi
declare -r arguments=("$0" "$@")
    # Handle zero arguments case (although this should not happen)
    if [ $(echo "${#arguments[@]}" '<' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo_error__109_v0 "Oops, no arguments provided"'!'" It should not happen. But it did. Please visit https://fuckit.sh and report this issue." 1;
        __AF_echo_error109_v0__53_9="$__AF_echo_error109_v0";
        echo "$__AF_echo_error109_v0__53_9" > /dev/null 2>&1
fi
    # First argument is the script name
    script_name="${arguments[0]}"
    # Set persona based on the script name, and export it for other modules to use.
    __AMBER_VAL_63=$( basename "${script_name}" );
    __AS=$?;
    persona="${__AMBER_VAL_63}"
    env_var_set__90_v0 "FUCKIT_PERSONA" "${persona}";
    __AS=$?;
    __AF_env_var_set90_v0__58_11="$__AF_env_var_set90_v0";
    echo "$__AF_env_var_set90_v0__58_11" > /dev/null 2>&1
    # initialize i18n
    init_i18n__309_v0 ;
    __AF_init_i18n309_v0__60_5="$__AF_init_i18n309_v0";
    echo "$__AF_init_i18n309_v0__60_5" > /dev/null 2>&1
    # Remaining arguments are passed to the script
    __SLICE_UPPER_64="${#arguments[@]}";
    __SLICE_OFFSET_65=1;
    __SLICE_OFFSET_65=$((__SLICE_OFFSET_65 > 0 ? __SLICE_OFFSET_65 : 0));
    __SLICE_LENGTH_66=$(echo "${#arguments[@]}" '-' $__SLICE_OFFSET_65 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __SLICE_LENGTH_66=$((__SLICE_LENGTH_66 > 0 ? __SLICE_LENGTH_66 : 0));
    script_args=("${arguments[@]:$__SLICE_OFFSET_65:$__SLICE_LENGTH_66}")
    # Check execution mode
    __AMBER_ARRAY_67=("-v" "--version" "version");
    array_contains__121_v0 __AMBER_ARRAY_67[@] "${script_args[0]}";
    __AF_array_contains121_v0__67_35="$__AF_array_contains121_v0";
    starts_with__20_v0 "${script_name}" "${__7_home_dir}""/.local/bin";
    __AF_starts_with20_v0__75_39="$__AF_starts_with20_v0";
    starts_with__20_v0 "${script_name}" "${__7_home_dir}""/.local/bin";
    __AF_starts_with20_v0__79_35="$__AF_starts_with20_v0";
    if [ $(echo $(echo "${#script_args[@]}" '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' "$__AF_array_contains121_v0__67_35" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo "${__0_VERSION}"
elif [ $(echo $(echo "${#script_args[@]}" '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${script_args[0]}" != "_uninstall" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        uninstall__209_v0 "${__7_home_dir}" "${__2_NAME}";
        __AF_uninstall209_v0__72_13="$__AF_uninstall209_v0";
        echo "$__AF_uninstall209_v0__72_13" > /dev/null 2>&1
elif [ $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo  '!' "$__AF_starts_with20_v0__75_39" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        install__208_v0 "${__7_home_dir}" "${__2_NAME}" "${__3_NAME_CIVIL}" "${__0_VERSION}" "${__4_URL}";
        __AF_install208_v0__76_13="$__AF_install208_v0";
        echo "$__AF_install208_v0__76_13" > /dev/null 2>&1
elif [ $(echo $(echo "${#script_args[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' "$__AF_starts_with20_v0__79_35" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        echo "hi"
else
        start_chat_session__298_v0 script_args[@];
        __AF_start_chat_session298_v0__84_13="$__AF_start_chat_session298_v0";
        echo "$__AF_start_chat_session298_v0__84_13" > /dev/null 2>&1
fi
