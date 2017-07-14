-   [Auxilium](#auxilium)
-   [Introduction](#introduction)
-   [Runtime Auxilium Downloads](#runtime-auxilium-downloads)
-   [Documentation](#documentation)
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
