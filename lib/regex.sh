#!/bin/bash
# This file contains regex related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


################################################################################
# Check if the input string contains the given literal pattern or not.
# Arguments:
#  string, pattern string (like: *)
# Outputs:
#  Boolean value
################################################################################
function contains_literal () {


### INPUT PARAMETERS

declare usr_input="${1}";

declare usr_pattern="${2}"


### PROCESSING

declare number_of_hits;

number_of_hits=$(echo "$usr_input" | fgrep -c "$2");


### OUTPUT

if ((0 < number_of_hits));

  then echo "true";

  else echo "false";

fi

}
