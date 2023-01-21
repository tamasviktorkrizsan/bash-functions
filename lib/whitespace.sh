#!/bin/bash
# This file contains whitespace replacing functions.
# Copyright (C) 2020-2023 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Remove whitespace and other OS prohibited characters from the input string.
# Arguments:
#   string
# Outputs:
#  corrected OS friendly string value.
################################################################################
function rename_whitespace_string() {

  ## INPUT PARAMETERS

  declare usr_input="${1}";


  ## PROCESSING

  echo "$usr_input" | tr ' ' '_';

  }


################################################################################
# Remove whitespace and other OS prohibited characters from filenames or string
# The behaviour depends on the enviroment where this function is called from
#
# Arguments:
# in interactive shell - exact filename or wildcard pattern
# in shell script - input string
#
# Outputs:
# Whitespaces (" ") replaced with underscores ("_")
# in interactive shell - rename input filename(s)
# in shell script - rename input string
################################################################################
function rename_whitespace() {


## INPUT PARAMETERS

declare usr_input="${1}";


declare string_fix;


if [ -n "$PS1" ]; then


  # call in interactive shell

  if $(contains_literal "$usr_input" "*"); then

    for i in $usr_input; do

      string_fix=$(rename_whitespace_string "$i");

      mv "$i" "$string_fix";

    done;


  else string_fix=$(rename_whitespace_string "$usr_input");

  fi;


  # call in shell script

  else string_fix=$(rename_whitespace_string "$usr_input");

    echo "$string_fix";

fi;

}
