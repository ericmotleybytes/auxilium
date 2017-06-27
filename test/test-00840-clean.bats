#!/usr/bin/env bats
load test_helper
@test "check auxenv clean" {
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
    exp=();
    [ -d /usr/local/bin ]
    [ -d /usr/bin ]
    export MYTEST="/usr/local/bin:$harddir:$softdir:$missdir:/usr/bin"
    # now clean
    source ../bin/auxenv clean MYTEST
    arr=();
    for part in $MYTEST; do
        arr+=("$part")
    done
    [ "${#arr[@]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "$harddir" ]
    [ "${arr[2]}" == "/usr/bin" ]
}
@test "check auxenv clean empty/unset lists" {
    #  clean an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv clean MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # clean an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv clean MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
# all done
