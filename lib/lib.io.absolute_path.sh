#!/bin/bash
# This file contains functions related to input-output operations.
# Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION


################################################################################
# Check and add absolute path to the input filename, if it doesnt contains one
# Convert path style from unix to dos.
# This feature is intended for DOS based filesystems only.
# Arguments:
#   input filename string
################################################################################
function absolute_path () {

declare usr_input="${1}";

declare usr_format="${2}";


declare output;

case $HOST_OS in

  "cygwin")

    declare cygpath_options="--windows --long-name --absolute";

    case $usr_format in

      "windows->json")

        output="$(cygpath $cygpath_options --mixed "$usr_input")";;


      "json->windows")

        output="$(cygpath $cygpath_options "$usr_input")";;

    esac;;


  "wsl")

    # TODO: this wsl option is not tested

    case $usr_format in

      "windows->json")

        output="$(wslpath -a -u "$usr_input")";;


      "json->dos")

        output="$(cygpath -a -m "$usr_input")";;

    esac;;


  "unix" | "macos" | "linux")

    output=$(readlink -e "$usr_input");;

esac;


echo "$output";

#echo "$output" | tr '\015' '\012';

}
