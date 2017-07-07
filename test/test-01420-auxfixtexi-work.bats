#!/usr/bin/env bats
load test_helper
@test "check auxfixtext repair work1" {
    #tempdir="$AUXILIUM_TEMPDIR"
    tempdir="$BATS_TMPDIR"
    #mkdir -p "$tempdir"
    fileflawed="fake/sample_flawed.texi"
    fileclean="fake/sample_clean.texi"
    file2test="$tempdir/sample2test.texi"
    #mkdir -p "tempdir"
    rm -f "$file2test"  # delete old version if any
    auxfixtexi -i $fileflawed -o $file2test
    run diff "$file2test" "$fileclean"
    [ "$status" == "0" ]
    #rm -rf "$tempdir"
}
@test "check auxfixtext repair work2" {
    #tempdir="$AUXILIUM_TEMPDIR"
    tempdir="$BATS_TMPDIR"
    #mkdir -p "$tempdir"
    fileflawed="fake/sample_flawed.texi"
    fileclean="fake/sample_clean.texi"
    file2test="$tempdir/sample2test.texi"
    #mkdir -p "tempdir"
    rm -f "$file2test"  # delete old version if any
    auxfixtexi --input=$fileflawed --output=$file2test
    run diff "$file2test" "$fileclean"
    [ "$status" == "0" ]
    #rm -rf "$tempdir"
}
# all done
