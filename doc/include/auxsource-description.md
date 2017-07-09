*auxsource* is a sourceable bash script which extends the capabilities
of the built-in bash command "source". Its primary feature is that
if a relative file specification is specified (a filename with no
directory or a relative directory) then it will search through 
a path-list (using the PATH environment variable by default) and
source the first match found. This makes working with sourceable
scripts a little more like working with executable scripts or programs.

auxsource uses the auxwhere executable script (also part of the auxilium
distribution) to find the exact file to be sourced. Command line parameters
on the auxsource command line cannot be passed to auxwhere because they
are reserved for use by whatever sourceable script is being invoked. However,
the "AUXSOURCE_OPTIONS" environment variable may be set to whatever auxwhere
options are desired. This allows full control over how sourceable files are
located.
