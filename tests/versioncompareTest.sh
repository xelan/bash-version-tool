#!/usr/bin/env bats

@test "Helptext is shown if no parameters are passed" {
    run ./versioncompare.sh
    [ "$status" -eq 64 ]
    [ "${lines[0]}" = "Usage: versioncompare.sh <versionA> <versionB>" ]
}
