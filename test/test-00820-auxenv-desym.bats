#!/usr/bin/env bats
load test_helper
@test "check auxenv desym" {
    IFS=":"
    harddir="$AUXILIUM_TEMPDIR/hard"
    softdir="$AUXILIUM_TEMPDIR/soft"
    missdir="$AUXILIUM_TEMPDIR/miss"
    mkdir -p "$harddir"
    [ -d "$harddir" ]
    pushd "$AUXILIUM_TEMPDIR" > /dev/null
    ln -s hard soft
    popd > /dev/null
    [ -d "$softdir" ]
    arr=();
    export MYTEST="/usr/local/bin:$harddir:$softdir:$missdir:/usr/bin"
    for part in $MYTEST; do arr+=("$part"); done
    cnt="${#arr[@]}"
    [ "${#arr[@]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "$harddir" ]
    [ "${arr[2]}" == "$softdir" ]
    [ "${arr[3]}" == "$missdir" ]
    [ "${arr[4]}" == "/usr/bin" ]
    # now desym
    source ../bin/auxenv desym MYTEST
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[@]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "$harddir" ]
    [ "${arr[2]}" == "$harddir" ]
    [ "${arr[3]}" == "$missdir" ]
    [ "${arr[4]}" == "/usr/bin" ]
}
@test "check auxenv desym empty/unset lists" {
    # desym an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv desym MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # desym an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv desym MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
# all done
