-   [Auxilium](#auxilium)
-   [Introduction](#introduction)
-   [Runtime Auxilium Downloads](#runtime-auxilium-downloads)
-   [Documentation](#documentation)
-   [Examples](#examples)
    -   [auxenv examples](#auxenv-examples)
    -   [auxsource examples](#auxsource-examples)
    -   [auxalias examples](#auxalias-examples)
    -   [auxwhere examples](#auxwhere-examples)
    -   [auxchecktap examples](#auxchecktap-examples)
-   [Authors](#authors)
-   [Legal](#legal)
-   [See Also](#see-also)

Auxilium
========

Shell utilities for paths, sourcing, aliasing, GUIDs, and unit test summaries

Introduction
============

*Auxilium* is the latin word for *support*. The "auxilium" package is an open-source project which contains a collection of bash shell executable and sourceable scripts which support, and make easier, many common Unix/Linux user tasks. All auxilium utilities are written in \*bash", the standard Linux interpretive shell language. This facilitates portability (between bash platforms) and ease of installation. Auxilium has no runtime prerequisites other than bash version 4.2 or higher.

The core auxilium utilities include:

-   **auxenv**. Setup, manipulation, and optimization of path-like environment variables such as *PATH*, *MANPATH*, and *LD\_LIBRARY\_PATH*.

-   **auxwhere**. Find files by filename search through path-like environment variable directories.

-   **auxsource**. An extended version of the bash built-in *source* command.

-   **auxalias**. Creates static or dynamic aliases for all auxilium sourceable scripts.

-   **auxchecktap**. Scans and checks TAP format unit test result logs, producing a summarized TAP test results log.

-   **auxguid**. Generates a pseudo random 128-bit (32 hex character) GUID/UUID.

Runtime Auxilium Downloads
==========================

Please see <https://ericmotleybytes.github.io/auxilium/> for available runtime download and runtime installation instructions.

Documentation
=============

For convenience the latest version of the user guide is also available online in both HTML and PDF formats:

-   [Auxilium User Guide (html)](https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.html)
-   [Auxilium User Guide (pdf)](https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.pdf)

Examples
========

auxenv examples
---------------

Here are some examples of using auxenv.

-   Displaying a pathlike environment variable:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv show DEMOPATH
        DEMOPATH is set to:
        /dir1:/dir2:/dir3
        Item breakdown:
          1=/dir1
          2=/dir2
          3=/dir3
        $ auxenv dump DEMOPATH
        /dir1
        /dir2
        /dir3

-   Prepending a directory:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv prepend DEMOPATH /dir0
        $ echo "$DEMOPATH"
        /dir0:/dir1:/dir2:/dir3

-   Inserting a directory:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv insert DEMOPATH "/dir1a" before "/dir2"
        $ echo "$DEMOPATH"
        /dir1:/dir1a:/dir2:/dir3

-   Erasing a directory by name:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv erase DEMOPATH "/dir2"
        $ echo "$DEMOPATH"
        /dir1:/dir3

-   Erasing a directory by position:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv erase DEMOPATH @2
        $ echo "$DEMOPATH"
        /dir1:/dir3

-   Working with alternate separators:

        $ export DEMOPATH="red|green|blue"
        $ auxenv --ifs="|" show DEMOPATH
        DEMOPATH is set to:
        red|green|blue
        Item breakdown:
          1=red
          2=green
          3=blue

auxsource examples
------------------

Here are some examples of using auxsource.

-   Sourcing a file somewhere in a PATH directory:

        $ auxsource myfile

-   Sourcing a file somewhere in a PATH directory and passing some parameters:

        $ auxsource myfile say "hello world"

-   Sourcing a file specified by absolute location and passing parameters:

        $ auxsource /home/alice/mything.bash "more" "parameters"

-   Sourcing a file somewhere in a MYPATH directory:

        $ export MYPATH="/home/alice:/home/bob"
        $ export AUXSOURCE_OPTIONS="--env=MYPATH"
        $ auxsource myfile "some" "more parameters"

auxalias examples
-----------------

Here are some examples of using auxalias.

-   Setting up static auxilium aliases to installation in /usr/local:

        $ source /usr/local/bin/auxalias
        $ alias auxenv
        alias auxenv='source /usr/local/bin/auxenv'

-   Setting up dynamic auxilium aliases which use PATH:

        $ source /usr/local/bin/auxalias
        $ alias auxenv
        alias auxenv='eval source $(auxwhere auxenv)'

auxwhere examples
-----------------

Here are some examples of using auxwhere.

-   Finding the first instance of a file somewhere in a PATH directory:

        $ auxwhere myfile
        /some/directory/myfile

-   Finding all instances of a file somewhere in a PATH directory:

        $ auxwhere --all myfile
        /some/directory/myfile
        /some/other/directory/myfile
        /another/directory/myfile

-   Finding the first instance of a file somewhere in a LD\_LIBRARY\_PATH directory.

        $ auxwhere --env=LD_LIBRARY_PATH libproxy.so.1
        /usr/lib64/libproxy.so.1

-   Finding a file and seeing how the file was found using two path-like environment variables.

        $ auxwhere --all --env=PRIMARYPATH --env=SECONDARYPATH myfile.bash
        /some/directory/myfile.bash    (Found via PRIMARYPATH)
        /another/directory/myfile.bash     (Found via SECONDARYPATH)

-   Finding a file searching multiple file types and a sub-directory.

        $ auxwhere --env=MANPATH --subdir=.man --type=.1 --type=.1.gz awk
        /usr/share/man/man1/awk.1.gz

auxchecktap examples
--------------------

Here are some examples of using auxchecktap.

-   Scanning a unit test results log file:

        $ auxchecktap auxilium.taplog
        1..1
        ok 1 /home/ericc/github/auxilium/test/auxilium.taplog: 85 tests.
        $ echo "$?"
        0

-   Scanning multiple unit test result log files:

        $ auxchecktap tmp*.taplog
        1..3
        ok 1 /home/ericc/github/auxilium/test/tmp1.taplog: 85 tests.
        ok 2 /home/ericc/github/auxilium/test/tmp2.taplog: 80 tests.
        ok 3 /home/ericc/github/auxilium/test/tmp3.taplog: 90 tests.
        $ echo "$?"
        0

-   Scanning a unit test log file with a failed unit test report in it:

        $ auxchecktap another.taplog
        1..1
        not ok 1 /home/ericc/github/auxilium/test/another.taplog: 85 tests.
        # Found 1 failed test.
        $ echo "$?"
        1

-   Reading TAP output from standard input:

        $ # an example what the bats unit test tool produces.
        $ # (see https://github.com/sstephenson/bats)
        $ bats --tap test-00510-auxenv-insert.bats
        1..4
        ok 1 check auxenv insert before dir
        ok 2 check auxenv insert after dir
        ok 3 check auxenv insert before pos
        ok 4 check auxenv insert after pos
        $ # piping unit test results info auxchecktap...
        $ bats --tap test-00510-auxenv-insert.bats | auxchecktap
        1..1
        ok 1 /dev/stdin: 4 tests.
        $ echo "$?"
        0

Authors
=======

Eric Alan Christiansen
eric@motleybytes.com
<https://www.linkedin.com/in/ericchristiansen/>

Legal
=====

Copyright © 2017 Eric Alan Christiansen.

This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to use and/or redistribute it under the conditions of the GNU General Public License v3.0.

See <https://www.gnu.org/licenses/gpl-3.0.en.html>

See Also
========

-   <https://ericmotleybytes.github.io/auxilium/> : The official auxilium information and download page.

-   <https://testanything.org/> : A description of TAP, the unit testing Test Anything Protocol.
