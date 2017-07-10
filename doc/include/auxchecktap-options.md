-s | --strict

:   Specifies that strict TAP format parsing rules will be followed. Poorly
    formatted unit test results will result in an error being reported.
    This is the default.

-n | --nostrict

:   Specifies that less restrictive TAP format parsing rules will be used.
    This sometimes helps when parsing rersult from unit test tools that
    only loosely follow TAP formatting rules.

-b | --brief

:   Specifies that when producing summary TAP results, a "not ok" result
    line will be produce when a problem is detected, but the optional "#"
    comment lines following the report line which describe the problem will
    not be produced.

-d | --debug

:   Specifies that extra debug information should be outrput to standard error.

-h | --help

:   Displays a brief auxchecktap usage summary. If used, this option
    should be the only option or parameter on the command line.

-v | --version

:   Displays auxchecktap version information. If used, this option
    should be the only option or parameter on the command line.
