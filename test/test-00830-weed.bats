#!/usr/bin/env bats
load test_helper
@test "check auxenv weed" {
    IFS=":"
    arr=();
    exp=();
    export MYTEST="/usr/local/bin:/notthere/dir1:/usr/bin:/notthere/dir2"
    for part in $MYTEST; do
        arr+=("$part")
        if [ -e "$part" ]; then
           exp+=("$part")
        fi
    done
    cnt="${#arr[@]}"
    [ "${#arr[@]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/notthere/dir1" ]
    [ "${arr[2]}" == "/usr/bin" ]
    [ "${arr[3]}" == "/notthere/dir2" ]
    # now weed
    source ../bin/auxenv weed MYTEST
    arr=();
    idx="0"
    for part in $MYTEST; do
        arr+=("$part")
        [ "${arr[$idx]}" == "${exp[$idx]}" ]
        idx=$(($idx+1))
    done
    [ "${#arr[@]}" == "${#exp[@]}" ]
}
@test "check auxenv weed empty/unset lists" {
    #  weed an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv weed MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # weed an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv weed MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
# all done
