--ifs="\<char\>" (default is ":")

:   Specifies the character which separates items within the environment variable value. For
    example, on Linux directories within the PATH ennvironment variable are separated by a
    colon (":") character. A colon (":") is the default separator if this option is not specified.

--ifs=x\<h\>\<h\>

:   Same as the --ifs option above, except the separating character can be specified via its ASCII
    value in two hex digits. For example, --ifs=x20 specifies a space character.

--unset-empty

:   If the final environment variable value being manipulated ends up being "" (an empty string)
    this option will cause the environment variable to be unset, not just left with a "" value.

-h | --help

:   Displays a brief auxenv command usage summary. If used, this option must be the only option
    or parameter on the command line.

-v | --version

:   Displays auxenv version information. If used, this option must be the only option
    or parameter on the command line.
