#!/usr/bin/env bats
load test_helper
@test "check auxenv insert before dir" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/one before /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/two before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    [ "${arr[4]}" == "/root/two" ]
    arr=();
    export MYTEST=""
    source ../bin/auxenv insert MYTEST /root/three before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv insert MYTEST /root/three before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
}
@test "check auxenv insert after dir" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/one after /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/two after /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    [ "${arr[4]}" == "/root/two" ]
    arr=();
    export MYTEST=""
    source ../bin/auxenv insert MYTEST /root/three after /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv insert MYTEST /root/three after /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
}
@test "check auxenv insert before pos" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/one before 3
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/two before 9
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    [ "${arr[4]}" == "/root/two" ]
    arr=();
    export MYTEST=""
    source ../bin/auxenv insert MYTEST /root/three before 9
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv insert MYTEST /root/three before 9
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
}
@test "check auxenv insert after pos" {
    export MYTEST="/usr/local/bin:/usr/bin:/dummy/bin"
    IFS=":"
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/one after 2
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv insert MYTEST /root/two after 9
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    [ "${arr[4]}" == "/root/two" ]
    arr=();
    export MYTEST=""
    source ../bin/auxenv insert MYTEST /root/three after 99
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv insert MYTEST /root/three after 99
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
}
# all done
