#!/bin/bash
# CLI tool for version parser
# see http://semver.org/
# Requirements:
# - bash 4
# - cat

source $(dirname ${BASH_SOURCE[0]})/parser/parse.sh

if [ -z "$1" ] || [ -z "$2" ]; then
cat <<EOT
Usage: version.sh <version> <part>
<version> is the version number to parse.

<part> is the version part which should be returned.
It can be MAJOR, MINOR, PATCH, EXTRA, BUILD or ALL.
EOT

    exit 64;
fi;

RESULT=$(andaris_version_parse $1 $2 2>&1);
RESULTCODE=$?;

echo "$RESULT";

exit $RESULTCODE;
