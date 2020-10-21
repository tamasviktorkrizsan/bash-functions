# bash-functions
basic bash functions and settings for 3rd party software scripting.


## Installation

Set a PATH environmental variable to the directory where you want store your library
files and copy the contents of the "function-library" folder to it.


## Usage

At the top of your custom script file, following the shebang `#!/bin/bash` line
include the "bash.inc.sh" library file.

`source bash.inc.sh`

After that, you can call these functions...


## Features

### next_script function

Chain (Queue) up the execution of your script files with the next_script function.
Put the function call at the end of your script.

`next_script "<path>" "<shell filename>";`


- In its default state, when both parameters are empty, the script above this function
will be executed as usual, and then a prompt message will be printed out by next_script.
The terminal window will be kept open as long as the user can check the
process results, then hit the enter key to close the window.

`next_script "" "";` OR `next_script;`


- If the <path> parameter is empty, then the script will looking for the next_script
file in the current folder.

`next_script "" "example.sh";`


- If both parameters are filled, then the terminal first will enter the folder via
the relative path from the previous script file folder, then the given shell file
in the target folder will be executed.

`next_script "../example_folder" "example.sh";`


### remove_whitespace function

If you want to replace whitespace with underscores in strings, you can utilize
this function.

`remove_whitespace "<string>";`


### rename_whitespace function

If you want to replace whitespace with underscores in filenames, you can utilize
this function.

`rename_whitespace <filename>`


If you call the function without any given input parameter, the function will
process all files and folders in the folder.

`remove_whitespace;` AKA `remove_whitespace "*";`  

If you want to run this function in a interactive shell source
`whitespace.sh` or the `bash.inc.sh` shell file in `home\<user>\.bash_profile`.
After this was done, next time when you fire up the Bash Prompt, the rename_whitespace
function automatically loads up.


### Additional features

- Enabled tracing, for debugging purposes.

`set -x`


- Multiple filename patterns enabled. This is useful when you want to accept
an array of possible input file formats.

`shopt -s nullglob;`


For example compatible FFMPEG audio input formats for conversion.

`user_input="*.wav *.flac *.m4a *.mp3 *.ac3 *.webm";`


## Sources

https://ss64.com/bash/
