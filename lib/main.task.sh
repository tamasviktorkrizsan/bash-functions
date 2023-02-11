#!/bin/bash
# This file contains the task function.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later



### INCLUDES

source header.bash.sh


### GLOBALS

declare -Ax parameters;


### FUNCTIONS

################################################################################
# Loop processing controller.
# Arguments:
# processor function name, processor function parameters
# Outputs:
# Loop through the given function
################################################################################
function task () {


### INPUT PARAMETERS


declare usr_function_name="${1}";

source $function_name.sh

declare usr_parameters="${2}";

declare json_list;

json_list=$(convert_json "${usr_parameters[input]}");



### EXECUTE

declare number_of_objects;

number_of_objects=$(count_json_objects "$json_list");


for object_index in $(seq 0 $number_of_objects); do

  ## Start Process a item from the list

  object=$(query_json "$json_list" "$object_index" "");

  $function_name "$object";

done;



}
