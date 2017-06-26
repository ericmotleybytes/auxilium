#!/usr/bin/env bats
load test_helper
@test "check auxenv find" {
    export MYTEST="/usr/local/bin:/usr/bin:/root/bin"
    stuff=`source ../bin/auxenv find MYTEST /usr/local/bin`
    [ "$stuff" == "1" ]
    stuff=`source ../bin/auxenv find MYTEST "/usr/bin"`
    [ "$stuff" == "2" ]
    stuff=`source ../bin/auxenv find MYTEST /root/bin`
    [ "$stuff" == "3" ]
    stuff=`source ../bin/auxenv find MYTEST /dummy`
    [ "$stuff" == "" ]
}
@test "check auxenv find empty" {
    export MYTEST=""
    stuff=`source ../bin/auxenv find MYTEST /usr/bin`
    [ "$stuff" == "" ]
}
@test "check auxenv find unset" {
    unset MYTEST
    stuff=`source ../bin/auxenv find MYTEST /usr/bin`
    [ "$stuff" == "" ]
}
# all done
