#!/bin/bash
# Deploys all branches of a Hugo repository to a structure of folders.
# Useful for deploying all PRs/branches of a Hugo installation to a test URL for viewing.

# Args: folder
TARGET_FOLDER="$1"

mkdir -p "${TARGET_FOLDER}"

# Track all remote branches locally
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done

# Pull the branches
git pull --all
git fetch --all

# Iterate each local branch, and check it out into tmp folder, then build into the destination folder
for BRANCH in $(git for-each-ref --format='%(refname:short)' refs/heads); do
    echo "Building ${BRANCH}"

    # Make folders
    mkdir -p "${TARGET_FOLDER}/${BRANCH}"
    TEMP_FOLDER=`mktemp -d`

    # Checkout the branch
    git --work-tree="${TEMP_FOLDER}" checkout "${BRANCH}" -- .

    # Build to the destination folder
    hugo --gc -b "${URL_BASE}/${BRANCH}" -s "${TEMP_FOLDER}" -d "${TARGET_FOLDER}/${BRANCH}"

    # Cleanup the temp folder
    rm -rf "${TEMP_FOLDER}"
done