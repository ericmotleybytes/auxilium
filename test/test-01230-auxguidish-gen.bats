#!/usr/bin/env bats
load test_helper
@test "check auxguidish guid generation lower" {
    for switch in "" "--lower" "-l"; do
        guid=`../bin/auxguidish $switch`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguidish guid generation upper" {
    for switch in "--upper" "-u"; do
        guid=`../bin/auxguidish $switch`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9A-F]+$ ]]
    done
}
@test "check auxguidish guid generation warn" {
    for switch in "--warn" "-w"; do
        guid=`../bin/auxguidish $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguidish guid generation debug" {
    for switch in "--debug" "-d"; do
        guid=`../bin/auxguidish $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
@test "check auxguidish guid generation uuidgen" {
    for switch in "--uuidgen"; do
        guid=`../bin/auxguidish $switch 2>/dev/null`
        [ "$?" == "0" ]
        [[ "${#guid}" == "32" ]]
        [[ "$guid" =~ ^[0-9a-f]+$ ]]
    done
}
# all done
