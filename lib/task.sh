#!/bin/bash
# This file contains json query related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


source header.bash.sh

### FUNCTIONS

################################################################################
# Make a JSON filelist with exact filenames from
# file patterns,exact files or from CSV file.
# Arguments:
#  Assoc array, (array/object) index, key
# Outputs:
# A array of JSON objects.
################################################################################
function task () {


### INPUT PARAMETERS


declare function_name="${1}";

source $function_name.sh


declare usr_input="${USR_PARAMETERS[input]}";


declare json_list;

json_list=$(convert_json "${USR_PARAMETERS[input]}");



### EXECUTE


declare number_of_objects;

number_of_objects=$(count_json_objects "$json_list");


for object_index in $(seq 0 $number_of_objects); do

  ## Start Process a item from the list

  object=$(query_json "$json_list" "$object_index" "");

  $function_name "$object";

done;



}
