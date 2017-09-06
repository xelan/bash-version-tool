#!/usr/bin/env bats

@test "Helptext is shown if no parameters are passed" {
    run ./versionhighest.sh
    [ "$status" -eq 64 ]
    [ "${lines[0]}" = "Usage: versionhighest.sh <versions> [version]" ]
}

@test "Highest version is returned if just a version list is passed" {
    run ./versionhighest.sh '0.8.9\n0.8.11\n0.9.0'

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "0.9.0" ]
}

@test "Version is lower than the highest in list" {
    run ./versionhighest.sh '0.8.9\n0.8.11\n0.9.0' 0.8.17

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "NO" ]
}

@test "Version is the same as the highest in list" {
    run ./versionhighest.sh '0.8.9\n0.8.11\n0.9.0' 0.9.0

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "YES" ]
}

@test "Version is higher than the highest in list" {
    run ./versionhighest.sh '0.8.9\n0.8.11\n0.9.0' 0.9.1

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "YES" ]
}

@test "Version is higher than the highest in list - new major version" {
    run ./versionhighest.sh '0.8.9\n0.8.11\n0.9.0' 1.0.0

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "YES" ]
}
