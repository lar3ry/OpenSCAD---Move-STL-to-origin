#!/bin/bash

# Exit on errors
set -e

# Passed argument $1 should be a file
if [[ ! -f "$1" ]]
then
    echo "Usage: ./run-in-docker.sh [stl file] [scad file]"
    exit 1
fi
INPUT_FILENAME=$(basename "$1")
INPUT_FILEDIR="$( cd "$( dirname "$1" )" >/dev/null 2>&1 && pwd )"
INPUT_FILEPATH="$INPUT_FILEDIR/$INPUT_FILENAME"

# Possible passed argument $2 will be used as an output file
if [ $# -gt 1 ]
then
    OUTPUT_FILENAME=$(basename "$2")
    OUTPUT_FILEDIR="$( cd "$( dirname "$2" )" >/dev/null 2>&1 && pwd )"
    OUTPUT_FILEPATH="$OUTPUT_FILEDIR/$OUTPUT_FILENAME"
fi

# Current directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Temp file info. This must match the values used in Dockerfile
TEMP_FILENAME=".passed_file.stl"
TEMP_FILEPATH="$SCRIPT_DIR/$TEMP_FILENAME"

# Copy passed argument to this directory for temporary usage
cp "$INPUT_FILEPATH" "$TEMP_FILEPATH"

cd $SCRIPT_DIR
docker build -t open-scad-stl .

if [ $# -gt 1 ]
then
    PIPE="> $OUTPUT_FILEPATH"
    echo "Will write result to $OUTPUT_FILEPATH"
    echo "Starting stldim.py..."
else
    echo "Starting stldim.py..."
    echo "----"
fi

CMD="docker run --rm --name running-open-scad-stl open-scad-stl | sed \"s/$TEMP_FILENAME/$INPUT_FILENAME/\" $PIPE"
eval $CMD