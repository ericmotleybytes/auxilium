#!/usr/bin/env bats
load test_helper
@test "check auxenv erase" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    # erase dir in list
    arr=();
    source ../bin/auxenv erase MYTEST /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # "erase" dir not in list
    arr=();
    source ../bin/auxenv erase MYTEST /usr/local/bin/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # erase first item in list
    arr=();
    source ../bin/auxenv erase MYTEST /usr/local/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/usr/bin" ]
    # erase last item in list
    arr=();
    source ../bin/auxenv erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "erase" dir from empty
    arr=();
    source ../bin/auxenv erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "erase" dir from unset
    unset MYTEST
    arr=();
    source ../bin/auxenv erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # erase last item in list with --unsetempty
    arr=();
    export MYTEST=/usr/bin
    source ../bin/auxenv --unsetempty erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "erase" dir from empty with --unsetempty
    arr=();
    export MYTEST=""
    source ../bin/auxenv --unsetempty erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "erase" dir from unset with --unsetempty
    unset MYTEST
    arr=();
    source ../bin/auxenv --unsetempty erase MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
}
@test "check auxenv erase symlink" {
    IFS=":"
    harddir="$AUXILIUM_TEMPDIR/hard"
    softdir="$AUXILIUM_TEMPDIR/soft"
    mkdir -p "$harddir"
    [ -d "$harddir" ]
    pushd "$AUXILIUM_TEMPDIR" > /dev/null
    ln -s hard soft
    popd > /dev/null
    [ -d "$softdir" ]
    arr=();
    export MYTEST="/usr/local/bin:$harddir:$softdir:/usr/bin"
    for part in $MYTEST; do arr+=("$part"); done
    cnt="${#arr[@]}"
    [ "${#arr[@]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "$harddir" ]
    [ "${arr[2]}" == "$softdir" ]
    [ "${arr[3]}" == "/usr/bin" ]
    # try erasing the sym link, hard dir should NOT be removed
    arr=();
    source ../bin/auxenv erase MYTEST "$softdir"
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "$harddir" ]
    [ "${arr[2]}" == "/usr/bin" ]
}
# all done
