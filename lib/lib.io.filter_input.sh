#!/bin/bash
# This file contains functions related to input-output operations.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later

### FUNCTION

################################################################################
# Improved version of the bash's default value handling.
#
# Arguments:
#   input filename string
################################################################################
function filter_input () {


### INPUT PARAMETERS

declare usr_input="${1}";

declare usr_key="${2^^}";


declare pattern=" |null|auto|default";


# fill the variable with a value from the "DEFAULT_" global variable

if $(contains_pattern "$usr_input" "$pattern"); then

  declare output="DEFAULT_$usr_key";

  echo "${!output}";


  else echo "$usr_input";

fi

}
