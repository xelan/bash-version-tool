#!/bin/bash
# Version comparator for semantic versioning
# see http://semver.org/
#
# Compares as specified in http://semver.org/spec/v2.0.0.html#spec-item-11
# Requirements:
# - bash 4

source $(dirname ${BASH_SOURCE[0]})/../parser/parse.sh

function andaris_version_compare() {
    VERSION_A=$1;
    VERSION_B=$2;

    RESULT_A_HIGHER='A';
    RESULT_B_HIGHER='B';
    RESULT_SAME='0';
    RESULT_EQUAL='0';

    A_MAJOR=$(andaris_version_parse $1 MAJOR 2>&1);
    if [ $? -ne 0 ]; then
        (>&2 echo 'Invalid version A!');

        return 65;
    fi;

    B_MAJOR=$(andaris_version_parse $2 MAJOR 2>&1);
    if [ $? -ne 0 ]; then
        (>&2 echo 'Invalid version B!');

        return 65;
    fi;

    if [ "$VERSION_A" == "$VERSION_B" ]; then
        echo "$RESULT_SAME";

        return 0;
    fi;

    A_MINOR=$(andaris_version_parse $1 MINOR 2>&1);
    A_PATCH=$(andaris_version_parse $1 PATCH 2>&1);
    A_EXTRA=$(andaris_version_parse $1 EXTRA 2>&1);

    B_MINOR=$(andaris_version_parse $2 MINOR 2>&1);
    B_PATCH=$(andaris_version_parse $2 PATCH 2>&1);
    B_EXTRA=$(andaris_version_parse $2 EXTRA 2>&1);

    # Compare major, minor and patch versions
    if [ $A_MAJOR -gt $B_MAJOR ]; then
        echo "$RESULT_A_HIGHER";

        return 0;
    elif [ $B_MAJOR -gt $A_MAJOR ]; then
        echo "$RESULT_B_HIGHER";

        return 0;
    fi;

    if [ $A_MINOR -gt $B_MINOR ]; then
        echo "$RESULT_A_HIGHER";

        return 0;
    elif [ $B_MINOR -gt $A_MINOR ]; then
        echo "$RESULT_B_HIGHER";

        return 0;
    fi;

    if [ $A_PATCH -gt $B_PATCH ]; then
        echo "$RESULT_A_HIGHER";

        return 0;
    elif [ $B_PATCH -gt $A_PATCH ]; then
        echo "$RESULT_B_HIGHER";

        return 0;
    fi;

    # If one version has an EXTRA version (prerelease) and one does not,
    # prefer the one without it.
    if [ -z "$A_EXTRA" ] && [ ! -z "$B_EXTRA" ]; then
        echo "$RESULT_A_HIGHER";

        return 0;
    elif [ -z "$B_EXTRA" ] && [ ! -z "$A_EXTRA" ]; then
        echo "$RESULT_B_HIGHER";

        return 0;
    fi;

    # EXTRA version is a string, compare lexically in ASCII sort order
    # TODO analyze in more detail according to SemVer §11
    if [[ "$A_EXTRA" > "$B_EXTRA" ]]; then
        echo "$RESULT_A_HIGHER";

        return 0;
    elif [[ "$B_EXTRA" > "$A_EXTRA" ]]; then
        echo "$RESULT_B_HIGHER";

        return 0;
    fi;

    # If no differences were found until here, the versions
    # are considered equal.
    echo "$RESULT_EQUAL";

    return 0;
}
