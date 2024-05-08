#!/bin/bash

# Function to get the project name from the directory structure
get_project_name() {
    local current_dir=$(pwd)
    local branch_name=$1
    local dir_name

    # Extract the project name by comparing each directory component to the branch name
    while [[ $current_dir != "/" ]]; do
        dir_name=$(basename "$current_dir")
        if [[ $branch_name == *"$dir_name"* ]]; then
            current_dir=$(dirname "$current_dir")
        else
            echo "$dir_name"
            break
        fi
    done
}

# Get the current branch name
branch_name=$(git rev-parse --abbrev-ref HEAD)

# Get the project name
project_name=$(get_project_name "$branch_name")

# Create the file and write project name and branch name to it
echo "$project_name" > .wakatime-project
echo "$branch_name" >> .wakatime-project

echo "Generated .wakatime-project file for branch ${branch_name}"

