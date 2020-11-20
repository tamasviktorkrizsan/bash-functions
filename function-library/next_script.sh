#!/bin/bash
# This file contains the next_script function.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

#########################################################################
# Start a script file.
# Arguments:
#   relative folder path, filename
# Outputs:
#   Execute the next script or keep the terminal window open
#########################################################################
function next_script() {


## Input Parameters

local user_folder="$1";

local user_file="$2";


## Global Variables

IFS=':';


## Processing

# If there is nothing to continue with, then keep the terminal window open.
if [[ -z "${user_file}" ]]
  then read -p "Press enter to continue...";


# Execute the next script in the current folder.
  elif [[ -z "${user_folder}" ]] && [[ -n "${user_file}" ]]
  then exec bash $user_file;


# Enter folder then execute the script file there.
  else
  cd $user_folder;
  exec bash $user_file;
fi

}
