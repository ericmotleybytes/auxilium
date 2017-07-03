# Auxilium - bash tools to help solve common problems

Auxilium provides a set of bash utility scripts which help solve some common
problems such as:

* Viewing and manipulating settings of list environment variables like PATH.
* Checking and managing TAP-compliant unit test results.
* Being able to generate a GUID/UUID without an additional programming language.
* Controlling bash "source" file selection with a path-like environment variable.
1\.  [Installation](#installation)  
2\.  [Installation of Run-Time Only Distribution](#installationofrun-timeonlydistribution)  
2.0.1\.  [System-Wide Run-Time Installation](#system-widerun-timeinstallation)  
2.0.2\.  [Single Account Run-Time Installation](#singleaccountrun-timeinstallation)  
3\.  [Installation using Full Source Distribution](#installationusingfullsourcedistribution)  
3.0.1\.  [System-Wide Installation from Sources](#system-wideinstallationfromsources)  
3.0.2\.  [Single Account Installation from Sources](#singleaccountinstallationfromsources)  
4\.  [Commands](#commands)  
<a name="installation"></a>

## 1\. Installation

<a name="installationofrun-timeonlydistribution"></a>

## 2\. Installation of Run-Time Only Distribution

<a name="system-widerun-timeinstallation"></a>

#### 2.0.1\. System-Wide Run-Time Installation

TBD

<a name="singleaccountrun-timeinstallation"></a>

#### 2.0.2\. Single Account Run-Time Installation

TBD
<a name="installationusingfullsourcedistribution"></a>

## 3\. Installation using Full Source Distribution

<a name="system-wideinstallationfromsources"></a>

#### 3.0.1\. System-Wide Installation from Sources

TBD

<a name="singleaccountinstallationfromsources"></a>

#### 3.0.2\. Single Account Installation from Sources

TBD

<a name="commands"></a>

## 4\. Commands

* **auxenv** - Solves many problems working with path-like environment
    variables such as PATH, MANPATH, LD_LIBRARY_PATH, and so forth. It can
    display current settings in an easy to read form. It can
    add, delete, and reorder directory positions, it can weed out duplicate
    or nonexistent directories, and much more. The power of auxenv allows
    system administrators and end-users to create more robust and flexible
    login initialization scripts. Auxenv is also very useful to anyone who
    needs to switch back and forth between different versions of a
    programming language, enhancing or replacing the Linux "scl" utility.
* **auxchecktap** - Helps check with "TAP" (Test Anything Protocol) unit
    test result files. Many unit testing tools for many different
    programming have to option to display or record test results in
    TAP format. Sometimes, however, if there are many unit tests, a TAP
    test result file might be very long and it is easy to miss a reported
    error somewhere in the middle. The TAP format also makes it possible
    to detect is unit testing stop prematurely without an error message,
    but humans often do not notice this subtle inconsistency.
    Auxchecktap finds these and other problems and presents an easier
    to read summary test result display, which is also in TAP format.
    Using auxchecktap it is also possible to create hierarchical summaries
    of unit tests from many projects and divisions.
* **auxguid** - Generates a 32 hexidecimal character representation of
    a 128 bit randomly generated GUID (Globally Unique IDentifier) using
    only bash. These are also sometimes called UUID's (Universally Unique
    IDentifiers). By default, an auxilium specific algorithm is used to
    generate the GUID using bash random, timestamp to nanoseconds, process
    id, etc. The odds of an accidental duplicate GUID collision are
    astronomically low. Optionally, if it is installed on the system,
    auxguid can use the Linux "uuidgen" utility.
* **auxsource** - Works pretty much like the standard bash "source"
    command, except that if only a filename (with no directory) is
    specified auxsource will search through a directory list in the
    AUXSOURCE_PATH environment variable (much like bash looks for
    executable programs using the PATH environment variable).
