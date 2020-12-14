# Bash-Functions
basic bash functions and settings for 3rd party software scripting.


## Installation

Set a PATH environmental variable to the directory where you want store your library
files and copy the contents of the "function-library" folder to it.


## Usage

At the top of your custom script file, following the shebang `#!/bin/bash` line
include the "bash.inc.sh" library file.

`source bash.inc.sh`

 After that, you can call these functions...


## Functions

### next_script

`next_script "<path>" "<shell filename>";`

Chain (Queue) up the execution of your script files with the next_script function.
Put the function call at the end of your script.

- `next_script "" "";` When **all** parameters are **empty**, the script above this function
will be executed as usual, then the terminal window will be kept open as long as the user can check the
process results, then hit the enter key to close the window.

- `next_script "" "example.sh";` If the **path** parameter is **empty**, then the script will looking for the next script
file in the current folder.

- `next_script "../example_folder" "example.sh";` If **all** parameters are **filled**, then the terminal first will enter the folder via
the relative path from the previous script file folder, then the given shell file
in the target folder will be executed.


### remove_whitespace

`remove_whitespace "<string>";`

If you want to replace whitespace with underscores in **strings**, you can utilize
this function.


### rename_whitespace

`rename_whitespace "<filename>"`

If you want to replace whitespace with underscores in **filenames**, you can utilize
this function.

- **default state:** when all parameters are empty, the function will
process all files and folders in the current folder.

- If you want to run this function in a interactive shell source the
`whitespace.sh` or the `bash.inc.sh` shell file in `home\<user>\.bash_profile`.
After this was done, next time when you fire up the Bash Prompt, the rename_whitespace
function automatically loads up.


## Additional features

- `set -x` Enabled tracing, for debugging purposes.

- `shopt -s nullglob;` Multiple filename patterns enabled. This is useful when you want to accept
an array of possible input file formats like `user_input="*.wav *.flac *.m4a *.mp3 *.ac3 *.webm";` for FFMPEG


## Developer notes

### code style

The code in this repository formatted according the standards of the Google Style Guides.
If you want to contribute to this project, then read the guide first.

https://google.github.io/styleguide/shellguide.html


## Sources

https://ss64.com/bash/
