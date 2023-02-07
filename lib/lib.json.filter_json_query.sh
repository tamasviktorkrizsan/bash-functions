#!/bin/bash
# This file contains json related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Query and filter the value of a JSON object key. If the value is empty,
# subtitute it by the following methods in order.
# 1. Search for the value in a global array ( "${USR_SETTINGS[$key]}" )
# set by the user as a input
# 2. Search for a global constant ("$DEFAULT_") set by a header file
# 3. Call a sourced library function to inspect the input and get a proper value
# for use.
# Arguments:
#   JSON object string, JSON key
# Returns:
#   value string
################################################################################


filter_json_query () {


### INPUT PARAMETERS

declare usr_object="${1}";

declare usr_key="${2}";


declare value;

declare result;


value="$(query_json "$usr_object" "" "$usr_key")";


# fill the variable with a value from the USR_PARAMETERS global assoc array

if [[ -z "${value}" ]] && [[ "${USR_PARAMETERS[$usr_key]}" != "" ]];

  then result=${USR_PARAMETERS[$usr_key]};


  # fill the variable with a value from the "DEFAULT_" global variable

elif [[ -z "${USR_PARAMETERS[$usr_key]}" ]] && [[ -n "$DEFAULT_${usr_key^^}" ]];

    then result="$DEFAULT_${usr_key^^}"


  # fill the variable with a value from a function

else result="$(get_$usr_key "$usr_object" )";

fi

echo "$result";

}
