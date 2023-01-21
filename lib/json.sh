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
# filename (pattern) , USR_PARAMETERS (global-)
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


declare usr_input="${1}";


  # estimate input type and prepare data for processing

  shopt -s nullglob;

  declare input_type;

  declare -a filelist_array;

  if $(contains_literal "${usr_input}" "*.csv"); then

    input_type="wildcard_csv_pattern";

    for i in ${usr_input}; do

      filelist_array[${#filelist_array[@]}]+="$(absolute_path "$i" "windows->json")";

    done;


  elif $(contains_literal "${usr_input}" "*."); then

    input_type="wildcard_pattern";


    for i in ${usr_input}; do

      filelist_array[${#filelist_array[@]}]+="$(absolute_path "$i" "windows->json")";

    done;


    elif $(contains_literal "${usr_input}" ".csv"); then

      input_type="exact_csv_file";


    else

      input_type="exact_file";

      filelist_array+="$(absolute_path "${usr_input}" "windows->json")";

  fi


  # according the input type, assemble the file list into a JSON string

  declare json_list;

  case $input_type in

    "exact_csv_file")

      json_list=$(csv2json "$usr_input");;


    "wildcard_csv_pattern")

     for i in ${usr_input}; do

       json_list=$(csv2json "$i");

     done;;


    "wildcard_pattern" | "exact_file" )


    # uniform data

    declare number_of_elements="${#USR_UNIFORM_PARAMETERS[@]}";

    declare element_counter=0;


    for key in "${!USR_UNIFORM_PARAMETERS[@]}"; do

        uniform_parameters+="\""$key"\":\""${USR_UNIFORM_PARAMETERS[$key]}"\"";

        element_counter=$(($element_counter+1));


        # insert commas for the end of each key-value pairs except the last one

        if (( $element_counter < $(($number_of_elements)) ));

            then json_list+=",";

        fi

    done;


    # unique data

    number_of_elements="${#filelist_array[@]}";

    element_counter=0;


    # start JSON string writing

    json_list="[";


    # unique data

    for input in "${filelist_array[@]}"; do

        json_list+="{\""input"\":\""$usr_input"\"";

        # uniform parameters

        json_list+="}";


        element_counter=$(($element_counter+1));


        # insert commas for the end of each key-value pairs except the last one

        if (( $element_counter < $(($number_of_elements)) ));

            then json_list+=",";

            fi

        done;

        json_list+="]";;

  esac;


  if [ "$BASH_SUBSHELL" -eq 0 ];

    then echo "$json_list" > "${i%.*}.json";

    else  echo "$json_list";

  fi

}
