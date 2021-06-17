#!/bin/bash
# This file contain the make_dir function.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

####################################################################
# Create directory with custom options.
# Arguments:
#   new directory name
####################################################################
function make_dir() {


### INPUT PARAMETERS

declare usr_input="${1:-OUTPUT}";


### CONSTANTS

declare -r MKDIR_CONFIG="--verbose --parents --mode=777";


### PROCESSING

declare input;

input=$(replace_whitespace "$usr_input");

declare log_suffix="make_dir_$input.log";


### OUTPUT

# TODO(tamasviktorkrizsan): temporarily disabled tee functionality to make
# the "make_dir" function work properly

if [[ -e $input ]];

  then >&2 echo "The folder named < $input > is already exist.";

  else mkdir $MKDIR_CONFIG "$input" >&2; # | tee "$input/$log_suffix";

fi

}
