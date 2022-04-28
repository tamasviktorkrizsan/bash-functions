#!/bin/bash
# This file contain the make_dir function.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

################################################################################
# Check for the existence for the given folder.
# If the folder doesn't exists create the directory with custom options.
# Arguments:
#   new directory or path name
################################################################################
function make_dir() {


### INPUT PARAMETERS

declare usr_input="${1:?ERROR! NOT A VALID INPUT!}";


### CONSTANTS

declare -r MKDIR_CONFIG="--verbose --parents --mode=777";


### OUTPUT

# TODO(tamasviktorkrizsan): temporarily disabled tee functionality to make
# the "make_dir" function work properly

# check if the dir exist

if [[ -e $usr_input ]]; then

>&2 echo "The folder named < $usr_input > is already exist. Skipping folder creation.";

else mkdir $MKDIR_CONFIG "$usr_input"; # >&2 | tee "$usr_input/$log_suffix";

fi

}
