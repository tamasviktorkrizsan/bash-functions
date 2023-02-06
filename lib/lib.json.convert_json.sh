#!/bin/bash
# This file contains json related functions.
# Copyright (C) 2022-2023 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

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


declare usr_input="${1}";

shopt -s nullglob;


# estimate the input type and assemble the file list into a JSON string

    # wildcard csv pattern

if $(contains_literal "$usr_input" "*.csv"); then

    echo "ERROR! Wildcard csv files not allowed";


    # exact csv file

    elif $(contains_literal "$usr_input" ".csv"); then

        declare json_list;

        json_list=$(csv2json "$usr_input");



    # wildcard pattern - expand to exact filenames

    elif $(contains_literal "$usr_input" "*."); then

        declare -a filelist_array;

        for i in $usr_input; do

            filelist_array+=("$(absolute_path "$i" "windows->json")");

        done;

        json_list=$(filename2json "$filelist_array");


# exact file

    else

        declare exact_file;

        exact_file="$(absolute_path "$usr_input" "windows->json")";

        json_list=$(filename2json "$exact_file");

  fi


  ### RETURN

  if [ -n "$PS1" ] &&  [ -z ${filelist_array} ];

    then echo "$json_list" > "${usr_input%.*}.json";

    else echo "$json_list";

   fi

}
