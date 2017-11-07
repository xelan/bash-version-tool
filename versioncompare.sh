#!/bin/bash
# CLI tool for version comparator
# Requirements:
# - bash 4
# - cat

source "$(dirname "${BASH_SOURCE[0]}")"/comparator/compare.sh

if [ -z "$1" ] || [ -z "$2" ]; then
cat <<EOT
Usage: versioncompare.sh <versionA> <versionB>

Returns A if the first version is higher than the second, 0 if they are equal,
and B if the second version is higher.
EOT

    exit 64;
fi;

RESULT=$(andaris_version_compare "$1" "$2" 2>&1);
RESULTCODE=$?;

echo "$RESULT";

exit $RESULTCODE;
