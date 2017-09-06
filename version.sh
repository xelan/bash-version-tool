#!/bin/bash
# CLI tool for version parser
# see http://semver.org/
# Requirements:
# - bash 4

source $(dirname ${BASH_SOURCE[0]})/parser/parse.sh

if [ -z "$1" ] || [ -z "$2" ]; then
    echo 'Usage: version.sh <version> <part>';
    echo '';
    echo '<version> is the version number to parse.';
    echo '';
    echo '<part> is the version part which should be returned.';
    echo 'It can be MAJOR, MINOR, PATCH, EXTRA, BUILD or ALL.';

    exit 64;
fi;

RESULT=$(andaris_version_parse $1 $2 2>&1);
RESULTCODE=$?;

echo "$RESULT";

exit $RESULTCODE;
