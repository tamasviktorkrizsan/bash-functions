# Bash-Functions
basic bash functions and settings for 3rd party software scripting.


## Installation

Set a PATH environmental variable to the directory where you want store your library
files and copy the contents of the "lib" folder to it.


## Usage

At the top of your custom script file, following the shebang `#!/bin/bash` line
include the "bash.inc.sh" file.

`source bash.inc.sh`

 After that, you can call these functions...


## Functions

### next_script

`next_script "<path>" "<shell filename>";`

Queue up the execution of your script files with the next_script function.
Put the function call at the end of your script.

- `next_script "" "";` When **all** parameters are **empty**, the script above this function
will be executed as usual, then the terminal window will be kept open as long as the user can check the
process results, then hit the enter key to close the window.

- `next_script "" "example.sh";` If the **path** parameter is **empty**, then the script will looking for the next script
file in the current folder.

- `next_script "../example_folder" "example.sh";` If **all** parameters are **filled**, then the terminal first will enter the folder via
the relative path from the previous script file folder, then the given shell file
in the target folder will be executed.



### rename_whitespace

`rename_whitespace "<filename or string>"`

The behaviour of this function depends on the enviroment where its called from.

- **called from shell files:** replace the whitespace(s) with underscores in **strings**

- **called from interactive shell:** replace the whitespace(s) with underscores in **filenames**

- If you want to run this function in a interactive shell source the
`whitespace.sh` or the `bash.inc.sh` shell file in `home\<user>\.bash_profile`.
After this was done, next time when you fire up the Bash Prompt, the rename_whitespace
function automatically loads up.


### task

`"<usr_parameters>"`

`task "<function name>"`

Looping control of a chosen function.

- Handles wildcard file pattern (*.format)

- Handles filenames with whitespace(s)



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

https://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words
