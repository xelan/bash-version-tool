#!/usr/bin/env bats

source ./sorter/sort.sh

@test "Error message is shown when invalid order is passed" {
    run andaris_version_sort "1.0.0\n1.2.0\n1.0.0" INVALID

    [ "$status" -eq 65 ]
    [ "${lines[0]}" = "Invalid order!" ]
}

@test "Empty versions array sorted returns empty array" {
    run andaris_version_sort "" ASC

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "" ]
}

@test "Versions are sorted in ascending order" {
    run andaris_version_sort '1.0.1\n0.9\n1.1\n1.11\n1.2\n1.2.99' ASC

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "0.9" ]
    [ "${lines[1]}" = "1.0.1" ]
    [ "${lines[2]}" = "1.1" ]
    [ "${lines[3]}" = "1.2" ]
    [ "${lines[4]}" = "1.2.99" ]
    [ "${lines[5]}" = "1.11" ]
}

@test "Versions are sorted in descending order" {
    run andaris_version_sort '1.0.1\n0.9\n1.1\n1.11\n1.2\n1.2.99' DESC

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "1.11" ]
    [ "${lines[1]}" = "1.2.99" ]
    [ "${lines[2]}" = "1.2" ]
    [ "${lines[3]}" = "1.1" ]
    [ "${lines[4]}" = "1.0.1" ]
    [ "${lines[5]}" = "0.9" ]
}
