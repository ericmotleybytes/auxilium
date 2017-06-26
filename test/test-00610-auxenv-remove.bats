#!/usr/bin/env bats
load test_helper
@test "check auxenv remove" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv remove MYTEST /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    arr=();
    source ../bin/auxenv remove MYTEST /usr/local/bin/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    arr=();
    source ../bin/auxenv remove MYTEST /usr/local/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/usr/bin" ]
    arr=();
    source ../bin/auxenv remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    arr=();
    source ../bin/auxenv remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv remove MYTEST /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
}
# all done
