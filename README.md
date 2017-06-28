# Auxilium : Auxiliary support for path-like environment variables.

Auxilium is designed to provide a way to easily and flexibly manage and manipulate
directory list environment variables such as PATH, MANPATH, LD_LIBRARY_PATH, and so
forth. Directories can easily be added and removed in whatever order is appropriate.
Optionally, duplicate and non-existent directories can also be purged from the list,
thereby helping performance and maintainability.

System administrators can easily develop and share small sourcable scripts to robustly
configure default environment variables settings. End-users can more safely customize
these environment variables to suit their personal needs and preferences.

## auxenv

The primary auxilium tool is a sourcable script called "auxenv". Because it is used to
manipulate environment variables within the context of the current process, the script
needs to be source'd, not executed as a command in a subprocess. Generally, a bash alias
is defined to abbreviate this. auxenv can display and manipulate list environment
variables with great power and flexibility.

## auxsource

It is common to develop small configuration scripts with auxenv commands to configure
diferent environments. Just like the auxenv script, these scripts must also be invoked
via the "source" built-in bash command. Using the standard source command is fine,
but the full location of the source file must be specified.

In some environments it is helpful to find trhe custom configuration scripts based on
a list of directories to search through. The auxilium sourceable script "auxsource"
does this based on a list of directories in the "AUXSOURCE_PATH" envirnment variable.

## Credits

The run-time auxilium scripts (auxenv and auxsource) are written in 100% bash scripting
language. All that is needed to run them is a standard bash shell.

Development unit testing (not required for end-users) is performed using "Bats" (Bash
Automated Testing System) available at https://github.com/sstephenson/bats .

Conversion of markoff files to html documentation and man pages (also not required
for end-users) is performed via "Ronn" system available at https://github.com/rtomayko/ronn .
