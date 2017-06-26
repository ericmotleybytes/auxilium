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
    # remove dir in list
    arr=();
    source ../bin/auxenv remove MYTEST /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # "remove" dir not in list
    arr=();
    source ../bin/auxenv remove MYTEST /usr/local/bin/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # remove first item in list
    arr=();
    source ../bin/auxenv remove MYTEST /usr/local/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/usr/bin" ]
    # remove last item in list
    arr=();
    source ../bin/auxenv remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "remove" dir from empty
    arr=();
    source ../bin/auxenv remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "remove" dir from unset
    unset MYTEST
    arr=();
    source ../bin/auxenv remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # remove last item in list with --unsetempty
    arr=();
    export MYTEST=/usr/bin
    source ../bin/auxenv --unsetempty remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "remove" dir from empty with --unsetempty
    arr=();
    export MYTEST=""
    source ../bin/auxenv --unsetempty remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "remove" dir from unset with --unsetempty
    unset MYTEST
    arr=();
    source ../bin/auxenv --unsetempty remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
}
# all done
