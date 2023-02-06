#!/bin/bash
# This file contains bash script development helper functions
# Copyright (C) 2022-2023 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


# FUNCTIONS
################################################################################
# Reload ("re-source") a shell file in a interactive shell.
# Arguments:
#  shell filename (optional).
# Outputs:
#   reload a shell file.
################################################################################

function rl () {

 declare -r DEFAULT_FILE=~/.bash_profile;

 declare usr_file=${1:-$DEFAULT_FILE};

 source $usr_file;

};
