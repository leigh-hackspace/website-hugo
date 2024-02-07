#!/bin/bash
# Deploys all branches of a Hugo repository to a structure of folders.
# Useful for deploying all PRs/branches of a Hugo installation to a test URL for viewing.
set -u

# Args: folder, baseurl
TARGET_FOLDER=$(realpath $1)
BASE_URL="$2"

mkdir -p "${TARGET_FOLDER}"

# Track all remote branches locally
git remote prune origin > /dev/null
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote" >/dev/null 2>&1; done

# Pull the branches
git pull --all > /dev/null
git fetch --all > /dev/null

# Iterate each local branch, and check it out into tmp folder, then build into the destination folder
for BRANCH in $(git for-each-ref --format='%(refname:short)' refs/heads); do
    echo "Building ${BRANCH}"

    # Make folders
    mkdir -p "${TARGET_FOLDER}/${BRANCH}"
    TEMP_FOLDER=`mktemp -d`

    # Checkout the branch
    git --work-tree="${TEMP_FOLDER}" checkout "${BRANCH}" -- .

    # Build to the destination folder
    hugo --gc -b "${BASE_URL}/${BRANCH}" -s "${TEMP_FOLDER}" -d "${TARGET_FOLDER}/${BRANCH}" > /dev/null

    # Cleanup the temp folder
    rm -rf "${TEMP_FOLDER}"
done

# Build the index page
INDEX_PAGE="${TARGET_FOLDER}/index.html"

echo -e "<h1>Branches</h1>\n<ul>" > "${INDEX_PAGE}"
for BRANCH in $(git for-each-ref --format='%(refname:short)' refs/heads); do
    echo "  <li><a href=\"/${BRANCH}\">${BRANCH}</a></li>" >> "${INDEX_PAGE}"
done
echo -e "</ul>\n<p>Last Updated: $(date)</p>" >> "${INDEX_PAGE}"

# Reset the repo back to main
git reset --hard > /dev/null