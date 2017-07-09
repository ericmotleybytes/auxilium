An executable script. Facilitates integration and checking of unit test
results. Most unit test tools are targeted towards a particular programming language,
which means most organizations have multiple unit test tools. Fortunately, there is a
widely adopted format standard for unit test result file called "TAP", which stands for
"Test Anything Protocol" (see <https://testanything.org/>). Most modern unit test tools
can product TAP format unit test result files. The auxchecktap utility scans these
TAP format unit test files and can optionally create a summary TAP unit test results file.
This makes it possible to create tiered hierarchically unit test summary reports.
This utility also checks unit test results files much more consistently and carefully than
is reasonably human possible. Error lines buried in the middle of long files are always
detected, abmormal early test suite termination without error messages are detected,
test sequence problems are detected, and so forth.
