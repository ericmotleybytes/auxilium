# Auxilium - bash tools to help solve common problems

Auxilium provides a set of bash utility scripts which help solve some common
problems such as:

* Viewing and manipulating settings of list environment variables like PATH.
* Checking and managing TAP-compliant unit test results.
* Being able to generate a GUID/UUID without an additional programming language.
* Controlling bash "source" file selection with a path-like environment variable.

Contents:
1\.  [Installation](#installation)  
1.1\.  [Installation_of_Run_Time_Distribution](#installation_of_run_time_distribution)  
1.1.1\.  [Run Time Distribution Single User Install](#runtimedistributionsingleuserinstall)  
1.1.2\.  [Run-Time Distribution, Multiple User Install](#run-timedistributionmultipleuserinstall)  
1.2\.  [Installation_of_Source_Distribution](#installation_of_source_distribution)  
1.2.1\.  [Source_Distribution_Single_User_Install](#source_distribution_single_user_install)  
1.2.2\.  [Source_Distribution_Multiple_User_Install](#source_distribution_multiple_user_install)  
2\.  [Commands](#commands)  
2.1\.  [auxenv](#auxenv)  
2.2\.  [auxchecktap](#auxchecktap)  
2.3\.  [auxguid](#auxguid)  
2.4\.  [auxsource](#auxsource)  

<a name="installation"></a>

## 1\. Installation

<a name="installation_of_run_time_distribution"></a>

### 1.1\. Installation_of_Run_Time_Distribution

<a name="runtimedistributionsingleuserinstall"></a>

#### 1.1.1\. Run Time Distribution Single User Install

TBD

<a name="run-timedistributionmultipleuserinstall"></a>

#### 1.1.2\. Run-Time Distribution, Multiple User Install

TBD

<a name="installation_of_source_distribution"></a>

### 1.2\. Installation_of_Source_Distribution

<a name="source_distribution_single_user_install"></a>

#### 1.2.1\. Source_Distribution_Single_User_Install

TBD

<a name="source_distribution_multiple_user_install"></a>

#### 1.2.2\. Source_Distribution_Multiple_User_Install

TBD

<a name="commands"></a>

## 2\. Commands

<a name="auxenv"></a>

### 2.1\. auxenv

**auxenv** - Solves many problems working with path-like environment
variables such as PATH, MANPATH, LD_LIBRARY_PATH, and so forth. It can
display current settings in an easy to read form. It can
add, delete, and reorder directory positions, it can weed out duplicate
or nonexistent directories, and much more. The power of auxenv allows
system administrators and end-users to create more robust and flexible
login initialization scripts. Auxenv is also very useful to anyone who
needs to switch back and forth between different versions of a
programming language, enhancing or replacing the Linux "scl" utility.

<a name="auxchecktap"></a>

### 2.2\. auxchecktap

**auxchecktap** - Helps check with "TAP" (Test Anything Protocol) unit
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

<a name="auxguid"></a>

### 2.3\. auxguid

**auxguid** - Generates a 32 hexidecimal character representation of
a 128 bit randomly generated GUID (Globally Unique IDentifier) using
only bash. These are also sometimes called UUID's (Universally Unique
IDentifiers). By default, an auxilium specific algorithm is used to
generate the GUID using bash random, timestamp to nanoseconds, process
id, etc. The odds of an accidental duplicate GUID collision are
astronomically low. Optionally, if it is installed on the system,
auxguid can use the Linux "uuidgen" utility.

<a name="auxsource"></a>

### 2.4\. auxsource

**auxsource** - Works pretty much like the standard bash "source"
command, except that if only a filename (with no directory) is
specified auxsource will search through a directory list in the
AUXSOURCE_PATH environment variable (much like bash looks for
executable programs using the PATH environment variable).
