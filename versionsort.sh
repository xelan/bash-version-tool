#!/bin/bash
# CLI tool for version sorting
#
# Requirements:
# - bash 4

source $(dirname ${BASH_SOURCE[0]})/sorter/sort.sh

if [ -z "$1" ]; then
    echo 'Usage: versionsort.sh <versions> [order]';
    echo '';
    echo '<versions> newline-delimited versions to sort';
    echo '';
    echo '[order] sort order (ASC or DESC, default ASC)';

    exit 64;
fi;

if [ -z "$2" ]; then
    ORDER='ASC';
else
    ORDER="$2";
fi;

RESULT=$(andaris_version_sort "$1" "$ORDER" 2>&1);
RESULTCODE=$?;

echo "$RESULT";

exit $RESULTCODE;
