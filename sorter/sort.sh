#!/bin/bash
# Version sorter for semantic versioning
# see http://semver.org/
#
# Requirements:
# - bash 4

source $(dirname ${BASH_SOURCE[0]})/../comparator/compare.sh

function andaris_version_sort() {
    VERSIONS_RAW="$1";
    ORDER="$2";

    if [ "$ORDER" != "ASC" ] && [ "$ORDER" != "DESC" ]; then
        (>&2 echo 'Invalid order!');

        return 65;
    fi;

    TEMP='';

    VERSIONS=();
    I=0;
    for VERSION in $(echo -e $VERSIONS_RAW); do
        VERSIONS[I]=$VERSION;
        ((I++));
    done;
    LENGTH=$I;

    # BubbleSort with andaris_version_compare as custom compare function.
    while [ true ]; do
        CHANGES=0;

        for (( I=0; I<=$LENGTH; I++ )); do
            if [ -z "${VERSIONS[$I+1]}" ]; then
                break;
            fi;

            # Compare the current item version with the next item version.
            COMPARE_RESULT=$(andaris_version_compare ${VERSIONS[$I]} ${VERSIONS[$I+1]} 2>&1);

            # If the current item version is higher, swap the two.
            if [ "$COMPARE_RESULT" == "A" ]; then
                TEMP=${VERSIONS[$I+1]};
                VERSIONS[$I+1]=${VERSIONS[$I]};
                VERSIONS[$I]=$TEMP;
                CHANGES=1;
            fi
        done;

        # No changes were done in the current for look => break.
        if [ $CHANGES -eq 0 ]; then
            break;
        fi;
    done;

    if [ "$ORDER" == "ASC" ]; then
        printf '%s\n' "${VERSIONS[@]}";

        return 0;
    fi;

    # Descending order.
    for (( I=$LENGTH-1; I>=0; I-- )); do
        echo "${VERSIONS[$I]}"
    done;

    return 0;
}
