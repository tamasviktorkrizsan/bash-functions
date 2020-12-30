#!/bin/bash
# Basic bash settings and function includes.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### BASH SETTINGS

set -x;

shopt -s nullglob;

IFS=' ';


### INCLUDE FUNCTIONS

source next_script.sh

source whitespace.sh
