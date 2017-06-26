#!/usr/bin/env bats
load test_helper
@test "check auxenv count" {
    export MYTEST="/usr/local/bin:/usr/bin"
    stuff=`source ../bin/auxenv count MYTEST`
    [ "$stuff" == "2" ]
}
@test "check auxenv count empty" {
    export MYTEST=""
    stuff=`source ../bin/auxenv count MYTEST`
    [ "$stuff" == "0" ]
}
@test "check auxenv count unset" {
    unset MYTEST
    stuff=`source ../bin/auxenv count MYTEST`
    [ "$stuff" == "0" ]
}
# all done
