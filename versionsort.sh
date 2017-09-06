#!/bin/bash
# CLI tool for version sorting
#
# Requirements:
# - bash 4
# - cat

source $(dirname ${BASH_SOURCE[0]})/sorter/sort.sh

if [ -z "$1" ]; then
cat <<EOT
Usage: versionsort.sh <versions> [order]

<versions> newline-delimited versions to sort.

[order] sort order (ASC or DESC), default ASC.
EOT

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
