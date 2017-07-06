#!/usr/bin/env bats
load test_helper
@test "check auxfixtext repair work" {
    tempdir="temp/auxfixtexi"
    fileflawed="fake/sample_flawed.texi"
    fileclean="fake/sample_clean.texi"
    file2test="$tempdir/sample2test.texi"
    mkdir -p "tempdir"
    rm -f "$file2test"
    auxfixtexi -i $fileflawed -o $file2test
    run diff $file2test $fileclean
    rm  -f "$file2test"
    rm -rf "$tempdir"
    [ "$status" == "0" ]
}
# all done
