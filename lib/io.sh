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


################################################################################
# Check for the existence for the given folder.
# If the folder doesn't exists create the directory with custom options.
# Arguments:
#   new directory or path name
################################################################################
function make_dir() {


### INPUT PARAMETERS

declare usr_input="${1:?ERROR! NOT A VALID INPUT!}";


### CONSTANTS

declare -r MKDIR_CONFIG="--verbose --parents --mode=777";


### OUTPUT

# TODO(tamasviktorkrizsan): temporarily disabled tee functionality to make
# the "make_dir" function work properly

# check if the dir exist

if [[ -e $usr_input ]]; then

>&2 echo "The folder named < $usr_input > is already exist. Skipping folder creation.";

else mkdir $MKDIR_CONFIG "$usr_input"; # >&2 | tee "$usr_input/$log_suffix";

fi

}



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


#####################################################################
# Create output filename (without extension)
# If output folder has been given, create foldername, make folder,
# and concat the output path from the file and foldername
# Arguments:
#  input file, output folder or path to target folder
#####################################################################


function handle_output () {


declare -xr DEFAULT_OUTPUT_FOLDER="OUTPUT";


### INPUT PARAMETERS

declare usr_object="${1}";

declare usr_input="$(query_json "$usr_object" "" "input")";

declare output_folder="$(filter_json_value "$usr_object" "output_folder")";


# check if the output path is on

#contains_literal "home\|Users"


### PROCESSING

# create output filename

declare input;

#declare inkut="${usr_input%.*}";

#input=$(basename "$inkut");

input=$(basename "${usr_input%.*}");

declare output_file;

output_file=$(rename_whitespace "$input");



# if the output folder parameter isn't empty, create the directory
# and concat the output path

declare output_path;

if [[ -n "${output_folder}" ]]; then

  declare output_folder;

  output_folder=$(rename_whitespace "$output_folder");

  make_dir "$output_folder";

  output_path="$output_folder/$output_file";

else

  output_path="$output_file";

fi


### OUTPUT

echo "$output_path";

}
