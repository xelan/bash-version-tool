#!/bin/bash
# Version parser for semantic versioning
# see http://semver.org/
# Requirements:
# - bash 4

function andaris_version_parse() {
    VERSION=$1;
    PART=$2;

    if [[ "$VERSION" =~ ^[vV]?([0-9]+)(\.([0-9]+))?(\.([0-9]+))?(\-([[a-zA-Z0-9\.-]+))?(\+([[a-zA-Z0-9\.-]+))?$ ]]; then 
        MAJOR=${BASH_REMATCH[1]}; 

        if [ -z "${BASH_REMATCH[3]}" ]; then
            MINOR='0';
        else
            MINOR=${BASH_REMATCH[3]};
        fi;

        if [ -z "${BASH_REMATCH[5]}" ]; then
            PATCH='0';
        else
            PATCH=${BASH_REMATCH[5]};
        fi;

        if [ -z "${BASH_REMATCH[7]}" ]; then
            EXTRA='';
        else
            EXTRA=${BASH_REMATCH[7]}
        fi;

        if [ -z "${BASH_REMATCH[9]}" ]; then
            BUILD='';
        else
            BUILD=${BASH_REMATCH[9]}
        fi;
    else 
      (>&2 echo 'Invalid version!');

      return 65;
    fi

    case "$PART" in
        'ALL')
            echo "Major: $MAJOR";
            echo "Minor: $MINOR";
            echo "Patch: $PATCH";
            echo "Extra: $EXTRA";
            echo "Build: $BUILD";

            return 0;
            ;;
        'MAJOR')
            echo "$MAJOR";

            return 0;
            ;;
        'MINOR')
            echo "$MINOR";

            return 0;
            ;;
        'PATCH')
            echo "$PATCH";

            return 0;
            ;;
        'EXTRA')
            echo "$EXTRA";

            return 0;
            ;;
        'BUILD')
            echo "$BUILD";

            return 0;
            ;;
        *)
            (>&2 echo 'Invalid part!');

            return 65;
            ;;
    esac
}
