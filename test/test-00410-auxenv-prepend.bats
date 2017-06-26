#!/usr/bin/env bats
load test_helper
@test "check auxenv prepend" {
    export MYTEST="/usr/local/bin:/usr/bin"
    IFS=":"
    arrone=(); for part in $MYTEST; do arrone+=("$part"); done
    [ "${#arrone[*]}" == "2" ]
    [ "${arrone[0]}" == "/usr/local/bin" ]
    [ "${arrone[1]}" == "/usr/bin" ]
    source ../bin/auxenv prepend MYTEST "/root"
    arrtwo=()
    for part in $MYTEST; do arrtwo+=("$part"); done
    [ "${#arrtwo[*]}" == "3" ]
    [ "${arrtwo[0]}" == "/root" ]
    [ "${arrtwo[1]}" == "/usr/local/bin" ]
    [ "${arrtwo[2]}" == "/usr/bin" ]
}
@test "check auxenv prepend to empty" {
    export MYTEST=""
    IFS=":"
    arr=(); for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    source ../bin/auxenv prepend MYTEST "/root"
    arr=()
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root" ]
}
@test "check auxenv prepend to unset" {
    unset MYTEST
    IFS=":"
    arr=(); for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    source ../bin/auxenv prepend MYTEST "/root"
    arr=()
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root" ]
}
# all done
