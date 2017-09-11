#!/bin/bash
# Requirements:
# - bash 4
# - bats

FAILURES=0;
TESTS=$(find . -name '*Test.sh');
for TEST in $TESTS; do
    bats $TEST || ((FAILURES++));
done;

if [ $FAILURES -gt 0 ]; then
    echo "Failed tests in $FAILURES test suite(s)!";

    exit 1;
fi
