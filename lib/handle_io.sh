#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

####################################################################
# Handles files with spaces and load specified software supported
# wildcard file formats if the given input file string is empty.
# Call this function right before a "FOR" loop.
# Arguments:
#  input file
####################################################################

function handle_input () {


### INPUT PARAMETERS

declare usr_input="${1}";


### PROCESSING


if [[ -n "$usr_input" ]]

# if the input file string is not empty, then set IFS to handle spaces and leave the input untouched

  then IFS=$'\n';

       echo "$usr_input";


# if the input file string is empty, then set IFS to parse spaces and load the software supported wildcard formats

  else  IFS=' ';

        echo $DEFAULT_INPUT;

fi

}


#####################################################################
# Handles output files. Creates output folder and replace whitespace
# with underscores in the output filename.
# Arguments:
#  input file, output folder
#####################################################################

function handle_output () {


### INPUT PARAMETERS

declare usr_input="${1}";

declare usr_output_folder="${2:-OUTPUT}";


### PROCESSING

# create a output directory

make_dir "$usr_output_folder";


# create output file

declare output_file;

output_file=$(replace_whitespace "${usr_input%.*}");


# concat a output path

declare output_path="$usr_output_folder/$output_file";


### OUTPUT

echo "$output_path";

}
