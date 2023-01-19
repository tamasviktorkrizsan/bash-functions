#!/bin/bash
# Bash User settings and functions for use in other bash projects.
# Copyright (C) 2022 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### SYSTEM SETTINGS

declare -r HOST_OS="cygwin";


## OPTIONAL SETTINGS

#set -ev;


### INCLUDE FUNCTIONS

source d2u.sh

source regex.sh

source whitespace.sh

source csv2json.sh

source json.sh

source io.sh

source next_script.sh
