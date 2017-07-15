*auxchecktap* is an executable bash script which scans TAP format unit test results
read from either standard input or one or more files. It outputs a summary of the
scan to standard output also in TAP format. The summary includes one "TAPFILE" report
line per log file scanned. The summary also includes one "TAPTOTAL" summary line with
totals for all the log files auxtapcheck just finished scanning. Finally, the summary
also includes one "TAPGRAND" summary line with grand totals for the just scanned
files plus any indirect "TAPGRAND" totals that the log files might have had embedded
in them. Thus, if auxchecktap scans the output of other auxchecktap logs the TAPGRAND
summary line indicates the total picture. This allows a hierarchy of unit test results
to be quickly and easily checked.

auxchecktap is part of the auxilium installation package.
