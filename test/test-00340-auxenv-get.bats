#!/usr/bin/env bats
load test_helper
@test "check auxenv get" {
    export MYTEST="/usr/local/bin:/usr/bin:/root/bin"
    stuff=`source ../bin/auxenv get MYTEST 1`
    [ "$stuff" == "/usr/local/bin" ]
    stuff=`source ../bin/auxenv get MYTEST 2`
    [ "$stuff" == "/usr/bin" ]
    stuff=`source ../bin/auxenv get MYTEST 3`
    [ "$stuff" == "/root/bin" ]
    stuff=`source ../bin/auxenv get MYTEST 4`
    [ "$stuff" == "" ]
    stuff=`source ../bin/auxenv get MYTEST 0`
    [ "$stuff" == "" ]
}
@test "check auxenv get empty" {
    export MYTEST=""
    stuff=`source ../bin/auxenv get MYTEST 1`
    [ "$stuff" == "" ]
}
@test "check auxenv get unset" {
    unset MYTEST
    stuff=`source ../bin/auxenv get MYTEST 1`
    [ "$stuff" == "" ]
}
# all done
