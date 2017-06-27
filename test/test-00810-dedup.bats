#!/usr/bin/env bats
load test_helper
@test "check auxenv dedup" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin:/usr/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    [ "${arr[3]}" == "/usr/bin" ]
    # dedup default order
    arr=();
    source ../bin/auxenv dedup MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
}
@test "check auxenv dedup topdown" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin:/usr/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    [ "${arr[3]}" == "/usr/bin" ]
    # dedup topdown
    arr=();
    source ../bin/auxenv dedup MYTEST topdown
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
}
@test "check auxenv dedup bottomup" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin:/usr/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    [ "${arr[3]}" == "/usr/bin" ]
    # dedup topdown
    arr=();
    source ../bin/auxenv dedup MYTEST bottomup
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/dummy/bin" ]
    [ "${arr[2]}" == "/usr/bin" ]
}
@test "check auxenv dedup empty/unset lists" {
    # dedup an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv dedup MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # dedup an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv dedup MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
# all done
