* AUXSOURCE_OPTIONS
  This is an optional environment variable. If set, then auxsource will use the value
  of AUXSOURCE_OPTIONS as command line switches for the embedded invocation of the
  "auxwhere" executable command. The auxwhere utility is also a part of the auxilium
  distribution and it is used to actually locate the exact location of the file to source.
  By default, if a relative filename is used, auxsource (via auxwhere) will search along
  the directories listed in the PATH environment variable in an attempt to locate
  the file to source. Through the AUXSOURCE_OPTIONS environment variable you can have
  full control of this search process. See the auxwhere documentation for more information.
