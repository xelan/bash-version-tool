#!/usr/bin/env bats

@test "Helptext is shown if no parameters are passed" {
    run ./versionsort.sh
    [ "$status" -eq 64 ]
    [ "${lines[0]}" = "Usage: versionsort.sh <versions> [order]" ]
}
