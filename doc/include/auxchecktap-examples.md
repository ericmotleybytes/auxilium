Here are some examples of using auxchecktap.

* Scanning a unit test results log file:

        $ auxchecktap auxilium.taplog
        1..1
        ok 1 /home/ericc/github/auxilium/test/auxilium.taplog: 85 tests.
        $ echo "$?"
        0

* Scanning multiple unit test result log files:

        $ auxchecktap tmp*.taplog
        1..3
        ok 1 /home/ericc/github/auxilium/test/tmp1.taplog: 85 tests.
        ok 2 /home/ericc/github/auxilium/test/tmp2.taplog: 80 tests.
        ok 3 /home/ericc/github/auxilium/test/tmp3.taplog: 90 tests.
        $ echo "$?"
        0

* Scanning a unit test log file with a failed unit test report in it:

        $ auxchecktap another.taplog
        1..1
        not ok 1 /home/ericc/github/auxilium/test/another.taplog: 85 tests.
        # Found 1 failed test.
        $ echo "$?"
        1

* Reading TAP output from standard input:

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
