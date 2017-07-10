*auxalias* is a sourceable bash script which defines either "static" or
"dynamic" aliases for all auxilium sourceable scripts (auxenv, auxsource,
and auxalias). A static alias is linked to a hardcoded directory.
A dynamic alias uses a path-like environment variable (PATH by default)
to dynamically determine each time it is invoked the first occurance of
the target file to source. This mimicks the PATH behavior of executable
scripts.

The auxalias script only defines aliases for auxilium sourcable scripts.
The auxilium executable programs, such as auxwhere, auxchecktap, and
auxguid do not need aliases.

auxalias is part of the auxilium installation package.
