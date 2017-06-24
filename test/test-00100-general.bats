#!/usr/bin/env bats
#
# Some simple general tests to verify testing setup.
#
load test_helper
@test "test shell addition" {
    let result=22+20
    [ "$result" -eq 42 ]
}
@test "test shell subtraction" {
    let result=22-20
    [ "$result" -eq 2 ]
}
@test "test shell multiplication" {
    let result=2*2*2*2
    [ "$result" -eq 16 ]
}
@test "test shell division" {
    let result=32/4
    [ "$result" -eq 8 ]
}
# all done
