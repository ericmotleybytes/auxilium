#!/usr/bin/env bats
load test_helper
@test "check auxguid guid generation lower" {
    for switch in "" "--lower" "-l"; do
        guid=`../bin/auxguid $switch`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguid guid generation upper" {
    for switch in "--upper" "-u"; do
        guid=`../bin/auxguid $switch`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9A-F]+$ ]]
    done
}
@test "check auxguid guid generation warn" {
    for switch in "--warn" "-w"; do
        guid=`../bin/auxguid $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguid guid generation debug" {
    for switch in "--debug" "-d"; do
        guid=`../bin/auxguid $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguid guid generation uuidgen" {
    for switch in "--uuidgen"; do
        guid=`../bin/auxguid $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
# all done
