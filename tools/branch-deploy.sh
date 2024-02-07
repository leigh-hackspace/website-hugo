#!/bin/bash
# Deploys all branches of a Hugo repository to a structure of folders.
# Useful for deploying all PRs/branches of a Hugo installation to a test URL for viewing.
set -u

# Args: folder
TARGET_FOLDER=$(realpath $1)
URL_BASE="$2"

INDEX_PAGE="${TARGET_FOLDER}/index.html"
mkdir -p "${TARGET_FOLDER}"

# Track all remote branches locally
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote" 2>/dev/null; done

# Pull the branches
git pull --all > /dev/null
git fetch --all > /dev/null

echo -e "<h1>Branches</h1>\n<ul>" > "${INDEX_PAGE}"

# Iterate each local branch, and check it out into tmp folder, then build into the destination folder
for BRANCH in $(git for-each-ref --format='%(refname:short)' refs/heads); do
    echo "Building ${BRANCH}"

    # Make folders
    mkdir -p "${TARGET_FOLDER}/${BRANCH}"
    TEMP_FOLDER=`mktemp -d`

    # Checkout the branch
    git --work-tree="${TEMP_FOLDER}" checkout "${BRANCH}" -- .

    # Build to the destination folder
    hugo --gc -b "${URL_BASE}/${BRANCH}" -s "${TEMP_FOLDER}" -d "${TARGET_FOLDER}/${BRANCH}" > /dev/null

    # Add to the index page
    echo "  <li><a href=\"/${BRANCH}\">${BRANCH}</a><li>" >> "${INDEX_PAGE}"

    # Cleanup the temp folder
    rm -rf "${TEMP_FOLDER}"
done

echo -e "</ul>\n<p>Last Updated: $(date)</p>" >> "${INDEX_PAGE}"

# Reset the repo back to main
git reset --hard > /dev/null