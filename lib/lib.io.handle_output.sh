#!/bin/bash
# This file contains functions related to input-output operations.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

#####################################################################
# Create output filename (without extension)
# If output folder has been given, create foldername, make folder,
# and concat the output path from the file and foldername
# Arguments:
#  input file, output folder or path to target folder
#####################################################################


function handle_output () {


declare -xr DEFAULT_OUTPUT_FOLDER="OUTPUT";


### INPUT PARAMETERS

declare usr_object="${1}";

declare usr_input="$(query_json "$usr_object" "" "input")";

declare output_folder="$(filter_json_value "$usr_object" "output_folder")";


# check if the output path is on

#contains_literal "home\|Users"


### PROCESSING

# create output filename

declare input;

#declare inkut="${usr_input%.*}";

#input=$(basename "$inkut");

input=$(basename "${usr_input%.*}");

declare output_file;

output_file=$(rename_whitespace "$input");



# if the output folder parameter isn't empty, create the directory
# and concat the output path

declare output_path;

if [[ -n "${output_folder}" ]]; then

  declare output_folder;

  output_folder=$(rename_whitespace "$output_folder");

  make_dir "$output_folder";

  output_path="$output_folder/$output_file";

else

  output_path="$output_file";

fi


### OUTPUT

echo "$output_path";

}
