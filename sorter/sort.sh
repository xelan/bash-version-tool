#!/bin/bash
# Version sorter for semantic versioning
# see http://semver.org/
#
# Requirements:
# - bash 4

source $(dirname ${BASH_SOURCE[0]})/../comparator/compare.sh
source $(dirname ${BASH_SOURCE[0]})/../parser/parse.sh

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
        andaris_version_parse $VERSION ALL > /dev/null 2>&1
        if [ $? -eq 65 ]; then
            continue;
        fi;

        VERSIONS[I]=$VERSION;
        ((I++));
    done;
    LENGTH=$I;

    # Insertion sort with andaris_version_compare as custom compare function.
    # see https://en.wikipedia.org/wiki/Insertion_sort#Algorithm_for_insertion_sort
    I=1;
    while [ $I -lt $LENGTH ]; do
        X=${VERSIONS[$I]};
        J=$((I-1));

        while [ $J -ge 0 ] && [ ! -z "$X" ]; do
            COMPARE_RESULT=$(andaris_version_compare ${VERSIONS[$J]} $X 2>&1);
            if [ "$COMPARE_RESULT" == "A" ]; then
                VERSIONS[$J+1]=${VERSIONS[$J]};
                ((J--));
            else
                break;
            fi;
        done;
        VERSIONS[$J+1]=$X;
        ((I++))
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
