-e \<envname\> | --env=\<envname\>

:   Specifies an environment variable containing a path-like list of directories through
    which auxwhere will search. If not specified, auxwhere uses the PATH environment
    variable by default. If this option is specified multiple times on the command line
    than multiple environment variable directory lists can be searched.

-t \<.filetype\> | --type=\<.filetype\>

:   Specifies a file type suffix to be appended to a file name when searching. By
    specifying this option multiple times multiple file type permutations can be searched for.
    For example, "--type=.tar --type=.tar.gz" will search for both \<filename\>.tar
    and \<filename\>.tar.gz in each directory.

\-s \<dir\> | --subdir=\<dir\>

:   Specifies a sub-directory to search within each directory. By specifying this option
    multiple times multiple sub directories can be searched.
    For example, "--subdir=man1 --subdir=man1p --subdir=man1x --env=MANPATH" will
    specify a search though each of those sub-directories for each directory listed
    in MANPATH.

-x | --exec

:   Specifies that only executable files will be matched. Executable files have the "x" bit
    set in their file protection mode.

-a | --all

:   Specifies that all matches found should be listed, one per line. By default, only
    the first match is listed.

-w | --how

: Specifies that additional information about how a match was found should be indicated. This
  is usually an indication of which environment variable lead to the match. Each match
  listed (one or all) is output as the file specification of the matched file, followed by
  a tab character, followed by a short "hoe message" on the same line.

--ifs="\<char\>"

:   Specifies the character which separates items within the environment variable value. For
    example, on Linux directories within the PATH ennvironment variable are separated by a
    colon (":") character. A colon (":") is the default separator if this option is not specified.

--

:   Forces all following parameters to be considered filenames. This is only needed if you have
    are looking for a filename that migfht be confused with a command line option, for example,
    a file actually named "--help".

-h | --help

:   Displays a brief auxwhere command usage summary. If used, this option should be the only option
    or parameter on the command line.

-v | --version

:   Displays auxwhere version information. If used, this option should be the only option
    or parameter on the command line.
