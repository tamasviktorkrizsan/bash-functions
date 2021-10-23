#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

#####################################################################
# Handles output files. Creates output folder and replace whitespace
# with underscores in the output filename.
# Arguments:
#  input file, output folder or path to target folder
#####################################################################

function handle_output () {


### INPUT PARAMETERS

declare usr_input="${1}";

declare usr_output="${2:-OUTPUT}";


### PROCESSING

# create a output directory or path

make_dir "$usr_output";


# create output file

declare output_file;

output_file=$(replace_whitespace "${usr_input%.*}");


# concat a output path

declare output_path="$usr_output/$output_file";


### OUTPUT

echo "$output_path";

}
