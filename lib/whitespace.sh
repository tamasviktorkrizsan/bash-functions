#!/bin/bash
# This file contains whitespace replacing functions.
# Copyright (C) 2020 Tamas Viktor Krizsan
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

  declare usr_input="${1-*}";


  ## PROCESSING

  echo "$usr_input" | tr ' |' '_--';

  }


################################################################################
# Remove whitespace and other OS prohibited characters from filenames or string
# Arguments:
#   wildcard - DEFAULT (*) or wildcard extension (*.mkv)
# Outputs:
#  renamed files. Whitespace (" ") replaced with underscores ("_")
################################################################################
function rename_whitespace() {


## INPUT PARAMETERS

declare usr_input="${1:-*}";


## CONSTANT SETTINGS

IFS='\n'


## VARIABLE SETTINGS

declare string_fix;


## PROCESSING

if [[ -e $usr_input ]] || [[ $usr_input == '*' ]]; then

  echo "INPUT DETECTED AS A FILENAME";

  for i in $usr_input;

    do string_fix=$(rename_whitespace_string "$i");

    mv "$i" "$string_fix";

  done;


else

  echo "INPUT DETECTED AS A INPUT STRING";

  string_fix=$(rename_whitespace_string "$usr_input");

  echo "$string_fix";

fi

}
