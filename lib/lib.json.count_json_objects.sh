#!/bin/bash
# This file contains json related functions.
# Copyright (C) 2022-2023 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS


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
