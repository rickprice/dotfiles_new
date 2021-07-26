#! /bin/bash

# Fail script if any command fails
set -e

## keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
## echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT

export SCRIPT_BASE=$(pwd)

# Process our shell snippets to load setup files
source_files_in() {
    local dir=$1

    if [[ -d "$dir" && -r "$dir" && -x "$dir" ]]; then
        for file in "$dir"/*; do
          [[ -x "$file" && -f "$file" && -r "$file" ]] && echo "Sourcing file [$file]" && . "$file"
        done
    fi
}

source_files_in $SCRIPT_BASE/setup_os.d
