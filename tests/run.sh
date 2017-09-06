#!/bin/bash
# Requirements:
# - bash 4
# - bats

TESTS=$(find . -name '*Test.sh');
for TEST in $TESTS; do
    bats $TEST;
done;