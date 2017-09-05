#!/usr/bin/env bats

source ./parser/parse.sh

@test "Error message is shown when invalid part is passed" {
    run andaris_version_parse 1.0.0 INVALID

    [ "$status" -eq 65 ]
    [ "${lines[0]}" = "Invalid part!" ]
}

@test "Error message is shown when invalid version is passed" {
    run andaris_version_parse x.2.3 MAJOR
    [ "$status" -eq 65 ]
    [ "${lines[0]}" = "Invalid version!" ]
}

@test "Version MAJOR.MINOR.PATCH" {
    run andaris_version_parse 1.2.3 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: " ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR.PATCH leading v is ignored" {
    run andaris_version_parse v1.2.3 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: " ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR.PATCH leading V is ignored" {
    run andaris_version_parse V1.2.3 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: " ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR" {
    run andaris_version_parse 1.2 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 0" ]
    [ "${lines[3]}" = "Extra: " ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR-EXTRA" {
    run andaris_version_parse 1.2-alpha-1 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 0" ]
    [ "${lines[3]}" = "Extra: alpha-1" ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR.PATCH-EXTRA" {
    run andaris_version_parse 1.2.3-beta3 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: beta3" ]
    [ "${lines[4]}" = "Build: " ]
}

@test "Version MAJOR.MINOR.PATCH+BUILD" {
    run andaris_version_parse 1.2.3+20170905a ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: " ]
    [ "${lines[4]}" = "Build: 20170905a" ]
}

@test "Version MAJOR.MINOR.PATCH-EXTRA+BUILD" {
    run andaris_version_parse 1.2.3-rc0+20170905a ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 1" ]
    [ "${lines[1]}" = "Minor: 2" ]
    [ "${lines[2]}" = "Patch: 3" ]
    [ "${lines[3]}" = "Extra: rc0" ]
    [ "${lines[4]}" = "Build: 20170905a" ]
}

@test "Version MAJOR.MINOR.PATCH-EXTRA+BUILD with long version strings" {
    run andaris_version_parse 57.16.135-alpha2+20170905a-build-1987 ALL
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Major: 57" ]
    [ "${lines[1]}" = "Minor: 16" ]
    [ "${lines[2]}" = "Patch: 135" ]
    [ "${lines[3]}" = "Extra: alpha2" ]
    [ "${lines[4]}" = "Build: 20170905a-build-1987" ]
    }

@test "Version MAJOR.MINOR.PATCH-EXTRA+BUILD with separate parts" {
    VERSION="7.13.25-beta-7+build3514"
    run andaris_version_parse $VERSION MAJOR
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "7" ]

    run andaris_version_parse $VERSION MINOR
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "13" ]

    run andaris_version_parse $VERSION PATCH
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "25" ]

    run andaris_version_parse $VERSION EXTRA
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "beta-7" ]

    run andaris_version_parse $VERSION BUILD
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "build3514" ]
}
