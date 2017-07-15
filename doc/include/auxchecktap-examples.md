Here are some examples of using auxchecktap.

* Scanning a unit test results log file:

        $ auxchecktap example1.taplog
        1..3
        ok 1 [TAPFILE: '/home/tester/test/example1.taplog' 89 tests, 0 errors]
        ok 2 [TAPTOTAL: 1 file, 89 tests, 0 errors]
        ok 3 [TAPGRAND: 1 file, 89 tests, 0 errors]
        1..1
        ok 1 /home/tester/test/auxilium.taplog: 85 tests.
        $ echo "$?"
        0

* Scanning multiple unit test result log files:

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

* Scanning a unit test log file with a failed unit test report in it:

        $ auxchecktap another.taplog
        1..3
        not ok 1 [TAPFILE: '/home/tester/test/another.taplog' 3 tests, 1 error]
        # Found 1 failed test.
        not ok 2 [TAPTOTAL: 1 file, 3 tests, 1 error]
        not ok 3 [TAPGRAND: 1 file, 3 tests, 1 error]
        $ echo "$?"
        1
