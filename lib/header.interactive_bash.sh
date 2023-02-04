#!/bin/bash
# Bash basic settings and functions for use in interactive shells.
# source this file in ".bash_profile" to use.
# Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### BASH SETTINGS

set -x;

shopt -s nullglob;

echo "LOAD INTERACTIVE SHELL FUNCTIONS";


### SYSTEM SETTINGS

declare -r HOST_OS="cygwin";


### INCLUDE FUNCTIONS


source dev_tools.sh

source d2u.sh

source regex.sh

source whitespace.sh

source csv2json.sh

source json.sh

source io.sh
