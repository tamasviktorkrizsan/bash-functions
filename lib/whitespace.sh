#!/bin/bash
# This file contains whitespace replacing functions.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

###########################################################################
# Remove whitespace from input string.
# Arguments:
#   string
# Outputs:
#  changed string value. Whitespace (" ") replaced with underscores ("_")
###########################################################################
function replace_whitespace() {

  ## Input Parameters

  local user_input="$1";


  ## Execute Command

  echo "$user_input" | tr ' ' '_';

  }


#####################################################################
# Remove whitespace from filenames.
# Arguments:
#   wildcard - DEFAULT (*) or wildcard extension (*.mkv)
# Outputs:
#  renamed files. Whitespace (" ") replaced with underscores ("_")
####################################################################
function rename_whitespace() {

  ## Input Parameters

  local user_input=${1:-*};


  ## Execute Command

  local filename;

  for i in $user_input;

  do filename=$(replace_whitespace "$i");

  mv "$i" $filename;

  done;

  }
