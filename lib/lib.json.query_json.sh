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
