#!/bin/bash
# This file contains the "filename2json" function.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Put exact filenames into JSON string. This is a helper function to the
# "convert_json" function.
# Arguments:
#   array or variable or list of strings (filename2json "file1" "file2" ...)
# Outputs:
#   echo json formatted string.
################################################################################
filename2json () {

# Input Parameters

declare -a usr_filelist_array=("$@");


# Count number of array items

number_of_items="${#usr_filelist_array[@]}";

item_counter=0;


# start JSON string writing

json_list="[";


# insert array items into the json string

for input in "${usr_filelist_array[@]}"; do

    json_list+="{\""input"\":\""$input"\"}";

    item_counter=$(($item_counter+1));


    # insert commas for the end of each key-value pairs except the last one

    if (( $item_counter < $(($number_of_items)) ));

        then json_list+=",";

    fi

done;

json_list+="]";

echo  "$json_list";

}
