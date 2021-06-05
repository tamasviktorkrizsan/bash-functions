#!/bin/bash
# This file contain the d2u function.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

####################################################################
# Convert line endings in text files to LF (Unix compatible).
# Arguments:
#   input file
####################################################################
function d2u () {


# INPUT PARAMETERS

declare usr_input=${1:-*.sh};


# OUTPUT

for i in $usr_input;
do dos2unix $i;
echo "EXIT CODE:" $?;
done;

}
