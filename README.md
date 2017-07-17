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
    -   [auxguid examples](#auxguid-examples)
-   [Platforms](#platforms)
-   [Contributing](#contributing)
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

-   **auxilium**. Displays version info for auxilium and all of its compoents.

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

        $ auxchecktap example1.taplog
        1..3
        ok 1 [TAPFILE: '/home/tester/test/example1.taplog' 89 tests, 0 errors]
        ok 2 [TAPTOTAL: 1 file, 89 tests, 0 errors]
        ok 3 [TAPGRAND: 1 file, 89 tests, 0 errors]
        1..1
        ok 1 /home/tester/test/auxilium.taplog: 85 tests.
        $ echo "$?"
        0

-   Scanning multiple unit test result log files:

        $ auxchecktap example*.taplog
        1..6
        ok 1 [TAPFILE: '/home/tester/test/example1.taplog' 89 tests, 0 errors]
        ok 2 [TAPFILE: '/home/tester/test/example2.taplog' 88 tests, 0 errors]
        ok 3 [TAPFILE: '/home/tester/test/example3.taplog' 40 tests, 0 errors]
        ok 4 [TAPFILE: '/home/tester/test/example4.taplog' 20 tests, 0 errors]
        ok 5 [TAPTOTAL: 4 files, 237 tests, 0 errors]
        ok 6 [TAPGRAND: 4 files, 237 tests, 0 errors]
        $ echo "$?"
        0

-   Scanning a unit test log file with a failed unit test report in it:

        $ auxchecktap another.taplog
        1..3
        not ok 1 [TAPFILE: '/home/tester/test/another.taplog' 3 tests, 1 error]
        # Found 1 failed test.
        not ok 2 [TAPTOTAL: 1 file, 3 tests, 1 error]
        not ok 3 [TAPGRAND: 1 file, 3 tests, 1 error]
        $ echo "$?"
        1

auxguid examples
----------------

Here are some examples of using auxguid.

-   Generate a GUID/UUID:

        $ auxguid
        2c7459630bbf26bc01ee5a33259a215a

-   Generate a lowercase GUID/UUID:

        $ auxguid --lower
        5bb659630c1f28006a2d5a57259a215a

-   Generate an uppercase GUID/UUID:

        $ auxguid --upper
        39EB59630C67184D7E0E5B1E259A215A

Platforms
=========

Auxilium programs are all written in [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)), the standard [Linux](https://en.wikipedia.org/wiki/Linux) shell language. Bash is an interpretive language, so as long as your platform has a relatively new version of Bash installed, it *should* be able to run the runtime Auxilium Bash scripts. There is no need of different runtime versions of Auxilium for different hardware platforms because there are no hard-compiled programs.

That being said, to date Auxilium has only been tested on Linux platforms. The author, however, would be very interested in user experience reports.

Contributing
============

Contributions are most welcome.

Please post bug reports and feature requests on the [auxilium issue tracker](https://github.com/ericmotleybytes/auxilium/issues) at <https://github.com/ericmotleybytes/auxilium/issues>.

To contribute project fixes or enhancements, please fork the project from the [Auxilium GitHub Repository](https://github.com/ericmotleybytes/auxilium) at <https://github.com/ericmotleybytes/auxilium> and then send pull requests for integration into the main distribution.

Authors
=======

Eric Alan Christiansen
eric@motleybytes.com
<https://www.linkedin.com/in/ericchristiansen/>

Legal
=====

Copyright © 2017 Eric Alan Christiansen

This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to use and/or redistribute it under the conditions of the MIT license (see <https://opensource.org/licenses/MIT>).

See Also
========

-   <https://ericmotleybytes.github.io/auxilium/> : The official auxilium information and download page.

-   <https://testanything.org/> : A description of TAP, the unit testing Test Anything Protocol.
