#!/usr/bin/env bats

@test "Helptext is shown if no parameters are passed" {
    run ./version.sh
    [ "$status" -eq 64 ]
    [ "${lines[0]}" = "Usage: version.sh <version> <part>" ]
}
