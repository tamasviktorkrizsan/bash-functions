#!/bin/bash
# This file contains json related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Query a key or a whole object from a JSON string.
# Arguments:
#  JSON string, (array/object) index, key
# Outputs:
#  JSON Object or value string. If the query results in a "null" then the output
# value will be a empty string.
################################################################################
query_json () {


## Input Parameters

declare usr_json_data=${1};

declare usr_array_index=${2};

declare usr_key=${3};


## Processing

declare data output;

# print a object if no key has been given

if [[ -z "${usr_key}" ]];

  then data=$(echo "$usr_json_data" | jq --raw-output ".[$usr_array_index]");


  # print a key from a solo object

  elif [[ -z "${usr_array_index}" ]]; then

    data=$(echo "$usr_json_data" | jq --raw-output ".$usr_key");


      # swap back the forwardslashes with backslahses

      if $(contains_literal "$data" ":/" ); then

       data=$(echo "$data" | tr '/' '\\' );

       #data=$(absolute_path "$data" "json->windows");


      fi


  # print a key from a selected object from a array

  else data=$(echo "$usr_json_data" | jq --raw-output ".[$usr_array_index].$usr_key");

fi


## Output

if [[ "$data" == "null" ]];

  then data="";

fi



echo "$data";

}




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


################################################################################
# Count the total number of Objects within a JSON string.
# Arguments:
#  JSON string
# Outputs:
#   echo the number of objects
################################################################################

count_json_objects () {


## Input Parameters

declare json_data=$1;


## Processing

declare -i left_tag_number;

declare -i right_tag_number;


# count and check opening/closing tag numbers

left_tag_number=$(grep -o '}' <<<"$json_data" | grep -c .);

right_tag_number=$(grep -o '{' <<<"$json_data" | grep -c .);


## Output

if (( left_tag_number == right_tag_number ));


  # for array indexes subtract (-1)

  then echo "$(($left_tag_number-1))";

  else >2 "ERROR!!! Invalid JSON structure!";

fi

}



################################################################################
# Create a JSON formatted string.
# Arguments:
#   user parameters (array)
#
#   csv files -> Converts the first line (heading) of the csv file into keys and
#   all the subsequent rows into values / objects
#
#   filename (pattern) -> Converts into a filelist
#
# Outputs:
#   call from interactive shell: outputs a json file.
#   call from script file: echo json formatted string.
################################################################################
function convert_json () {


# if the input is not assoc array, convert it.

if [[ ${1@a} = A ]];

    then declare -n usr_parameters="${1}";

    else declare -A usr_parameters=( [input]="${1}" );

fi


shopt -s nullglob;


# estimate the input type and assemble the file list into a JSON string

    # wildcard csv pattern

if $(contains_literal "${usr_parameters[input]}" "*.csv"); then

    echo "ERROR! Wildcard csv files not allowed";


    # exact csv file

    elif $(contains_literal "${usr_parameters[input]}" ".csv"); then

        declare json_list;

        json_list=$(csv2json "${usr_parameters[input]}");



    # wildcard pattern - expand to exact filenames

    elif $(contains_literal "${usr_parameters[input]}" "*."); then

        declare -a filelist_array;

        for i in ${usr_parameters[input]}; do

            filelist_array+=("$(absolute_path "$i" "windows->json")");

        done;

        json_list=$(filename2json "$filelist_array");


# exact file

    else

        declare exact_file;

        exact_file="$(absolute_path "${usr_parameters[input]}" "windows->json")";

        json_list=$(filename2json "$exact_file");

  fi


  ### RETURN

  if [ -n "$PS1" ];

    then echo "$json_list" > "${i%.*}.json";

    else  echo "$json_list";

  fi

}
