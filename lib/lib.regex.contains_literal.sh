#!/bin/bash
# This file contains regex related functions.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

################################################################################
# Check if the input string contains the given literal string or not.
# You can reverse it ("NOT_contains") with the 3rd optional parameter value: "-v"
# Arguments:
#  string, pattern (literal string, like: *)
# Outputs:
#  Boolean value
################################################################################
function contains_literal () {

### INPUT PARAMETERS

declare usr_input="${1}";

declare usr_pattern="${2}";

declare switch="${3}";


### PROCESSING

declare number_of_hits;

number_of_hits=$(echo "$usr_input" | fgrep $switch -c "$usr_pattern");


### OUTPUT

if ((0 < number_of_hits));

  then echo "true";

  else echo "false";

fi

}
