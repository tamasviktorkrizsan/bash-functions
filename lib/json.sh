#!/bin/bash
# This file contains json query related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Query a key or a whole object from a JSON string.
# Arguments:
#  JSON string, (array/object) index, key
# Outputs:
#  JSON Object or value string
################################################################################
query_json () {


## Input Parameters

declare usr_json_data=${1};

declare usr_array_index=${2};

declare usr_key=${3};


## Processing

declare data;

# print a object if no key has been given

if [[ -z "${usr_key}" ]];

  then data=$(echo "$usr_json_data" | jq ".[$usr_array_index]");


  # print a key from a solo object

  elif [[ -z "${usr_array_index}" ]];
  then data=$(echo "$usr_json_data" | jq ".$usr_key");


  # print a key from a selected object from a array

  else data=$(echo "$usr_json_data" | jq ".[$usr_array_index].$usr_key");

fi


## Output

if [[ -n "${data}" ]];

  then echo $data;

  else echo "null";

fi

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

declare left_tag_number;

declare right_tag_number;


# count and check opening/closing tag numbers

left_tag_number=$(grep -o '}' <<<"$json_data" | grep -c .);

right_tag_number=$(grep -o '{' <<<"$json_data" | grep -c .);


## Output

if (( left_tag_number == right_tag_number ));

  then echo "$left_tag_number";

  else >2 "ERROR!!! Invalid JSON structure!";

fi

}
