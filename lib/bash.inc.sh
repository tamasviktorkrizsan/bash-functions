#!/bin/bash
# Basic bash settings and function includes.
# Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### BASH SETTINGS

set -x;

shopt -s nullglob;

#IFS=' ';

IFS='\n'


### INCLUDE FUNCTIONS

source d2u.sh

source handle_output.sh

source make_dir.sh

source next_script.sh

source whitespace.sh
