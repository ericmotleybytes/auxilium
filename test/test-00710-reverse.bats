#!/usr/bin/env bats
load test_helper
@test "check auxenv reverse" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    # reverse dir list
    arr=();
    source ../bin/auxenv reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/dummy/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/usr/local/bin" ]
    # reverse an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # reverse an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
# all done
