#!/bin/bash
# CLI tool for returning the highest version
# or determining if a given version is the highest.
#
# Requirements:
# - bash 4
# - cat
# - tail

source $(dirname ${BASH_SOURCE[0]})/comparator/compare.sh
source $(dirname ${BASH_SOURCE[0]})/sorter/sort.sh

if [ -z "$1" ]; then
cat <<EOT
Usage: versionhighest.sh <versions> [version]

<versions> newline-delimited versions to sort

[version] optional version to compare

Output:
If only a version list is specified, the highest version of that list is output.

If a specific version is specified as well, YES is output if it is the same as or 
higher than the highest version in the list, NO otherwise.
EOT

    exit 64;
fi;

HIGHEST_VERSION=$(andaris_version_sort "$1" ASC | tail -n 1);
RESULTCODE=$?;

if [ -z "$2" ]; then
    echo "$HIGHEST_VERSION";

    exit $RESULTCODE;
fi;

RESULT=$(andaris_version_compare "$HIGHEST_VERSION" "$2");
RESULTCODE=$?;
if [ $RESULTCODE -ne 0 ]; then
    exit $RESULTCODE;
fi;

if [ "$RESULT" == "B" ] || [ "$RESULT" == "0" ]; then
    echo "YES";
else
    echo "NO";
fi;

exit 0;
