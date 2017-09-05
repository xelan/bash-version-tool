#!/usr/bin/env bats

source ./comparator/compare.sh

@test "Error message is shown when invalid version A is passed" {
    run andaris_version_compare INVALID 1.0.0

    [ "$status" -eq 65 ]
    [ "${lines[0]}" = "Invalid version A!" ]
}

@test "Error message is shown when invalid version B is passed" {
    run andaris_version_compare 1.0.0 INVALID
    [ "$status" -eq 65 ]
    [ "${lines[0]}" = "Invalid version B!" ]
}

@test "Same versions return 0" {
    run andaris_version_compare 1.0.0 1.0.0
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "0" ]
}

@test "Equal versions return 0" {
    run andaris_version_compare 1.0.0 1.0
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "0" ]
}

@test "Version MAJOR.MINOR.PATCH - A higher PATCH version" {
    run andaris_version_compare 1.2.3 1.2.0
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Version MAJOR.MINOR.PATCH - B higher PATCH version" {
    run andaris_version_compare 1.2.0 1.2.3
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}

@test "Version MAJOR.MINOR.PATCH - A higher MINOR version" {
    run andaris_version_compare 1.3.0 1.2.0
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Version MAJOR.MINOR.PATCH - B higher MINOR version" {
    run andaris_version_compare 1.2.0 1.3.0
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}

@test "Version MAJOR.MINOR.PATCH - A higher MAJOR version" {
    run andaris_version_compare 2.0.0 1.9.0
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Version MAJOR.MINOR.PATCH - B higher MAJOR version" {
    run andaris_version_compare 3.9.11 4.4.2
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}

@test "Version MAJOR.MINOR.PATCH (A) is preferred over MAJOR.MINOR.PATCH-EXTRA (B)" {
    run andaris_version_compare 4.2.10 4.2.10-rc4
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Version MAJOR.MINOR.PATCH (B) is preferred over MAJOR.MINOR.PATCH-EXTRA (A)" {
    run andaris_version_compare 4.2.10-beta2 4.2.10
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}

@test "Prerelase versions (same type) are ordered lexically (A higher)" {
    run andaris_version_compare 4.2.10-beta2 4.2.10-beta1
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Prerelase versions (same type) are ordered lexically (B higher)" {
    run andaris_version_compare 4.2.10-beta1 4.2.10-beta2
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}

@test "Prerelase versions (different type) are ordered lexically (A higher)" {
    run andaris_version_compare 4.2.10-beta2 4.2.10-alpha5
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "A" ]
}

@test "Prerelase versions (different type) are ordered lexically (B higher)" {
    run andaris_version_compare 4.2.10-beta2 4.2.10-rc5
    echo "$status";
    echo "${lines[0]}";
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "B" ]
}