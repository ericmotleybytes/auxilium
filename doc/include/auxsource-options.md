-h | --help

:   Displays a brief auxenv command usage summary. If used, this option must be the only option
    or parameter on the command line.

-v | --version

:   Displays auxenv version information. If used, this option must be the only option
    or parameter on the command line.

--

:   Indicates that all remaining parameters are for the sourceable file. You will
    probably never need to use this, but if for some bizarre reason you had a file
    named "--help", for example, the only way to auxsource it would be to specify
    "-- --help" instead of just "--help".
