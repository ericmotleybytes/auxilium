#!/usr/bin/env bats
#
# Check that required aliases are defined.
#
load test_helper
@test "check auxenv alias" {
    name=$(alias auxenv 2>/dev/null)
    [ ! -z "$name" ]
}
@test "check auxsource alias" {
    name=$(alias auxsource 2>/dev/null)
    [ ! -z "$name" ]
}
# all done
