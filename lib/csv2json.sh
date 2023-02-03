#!/bin/bash
# This file contains the csv2json function.
# Copyright (C) 2022-2023 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

################################################################################
# Convert Excel compatible csv files to JSON. This is a helper function of the
# convert_json function.
# Arguments:
#   exact csv filename or wildcard csv pattern.
# Outputs:
#   echo json formatted string.
################################################################################
csv2json () {


## Input Parameters

declare usr_input="${1:-*.csv}";


## Processing

for i in $usr_input; do


dos2unix "$usr_input";

  read first_row < "$usr_input";

    echo $first_row;


    ## Heading

    # count the number of headings/columns

    declare -i number_of_fields;

    number_of_fields=$(echo $first_row | awk -F, {'print NF'});


    # save heading names to a array

    declare -a key_array;

    declare -i key_index=0;

    while (( key_index < number_of_fields )); do

      key_array[$key_index]=$(echo $first_row |\

      awk -v position_index=$((key_index + 1)) -F"," '{print $position_index}');

      key_index=$((key_index+1));

    done;


    ## Table Cells

    # count records

    declare -i number_of_records;

    number_of_records="$(cat "$usr_input" | wc -l)";

    declare -i record_counter=0;

    declare -i field_counter;

    declare value;


    # begin writing the string

    declare json_string="[";


    # loop through the records

    while (( record_counter < number_of_records )); do read each_record

      if (( record_counter > 0 )); then

        # reset field counter when comes a new record

        field_counter=0;

        json_string+="{";


	      # loop through the fields in a record and add keys and values

	      while (( field_counter < number_of_fields )); do

	        value=$(echo $each_record |\

          awk -v position_index=$((field_counter + 1)) -F"," '{print $position_index}');


          # filter input value

          if $(contains_literal "$value" ":/" ); then

           data=$(absolute_path "$data" "windows->json");

          fi


          json_string+="\""${key_array[$field_counter]}"\":\""$value"\"";

          field_counter=$((field_counter+1));

          # insert commas for the end of each key-value pairs except the last one

          if (( field_counter < number_of_fields ));

            then json_string+=",";

          fi

        done;


    # finaly add the object's closing tag

      json_string+="}";

      if (( record_counter < $((number_of_records-1)) ));

	      then json_string+=",";

	    fi

    fi

    record_counter=$((record_counter+1));

  done < "$usr_input"

  json_string+="]";


  echo "$json_string";

done;

}
