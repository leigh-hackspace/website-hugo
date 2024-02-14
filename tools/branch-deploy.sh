#!/bin/bash
# Deploys all branches of a Hugo repository to a structure of folders.
# Useful for deploying all PRs/branches of a Hugo installation to a test URL for viewing.
set -u

# Args: folder, baseurl
TARGET_FOLDER=$(realpath $1)
BASE_URL="$2"

# Arguments to add to the Hugo call
HUGO_ARGUMENTS="--gc"

# Ensure the target folder exists
mkdir -p "${TARGET_FOLDER}"

# Checkout a local bare copy, to speed up later checkouts
ORIGIN=$(git config --get remote.origin.url)
BARE_FOLDER=`mktemp -u -d`
echo "Cloning upstream at ${ORIGIN}"
git clone --quiet --bare "${ORIGIN}" "${BARE_FOLDER}"

# Get a list of branch names on origin
BRANCHES=$(git ls-remote -h origin | awk '{print $2}'| cut -d'/' -f3-)

# Iterate each local branch, and check it out into tmp folder, then build into the destination folder
for BRANCH in $BRANCHES; do
    echo "Building ${BRANCH}"

    # Make folders
    mkdir -p "${TARGET_FOLDER}/${BRANCH}"
    TEMP_FOLDER=`mktemp -u -d`

    # Checkout the branch
    git clone -q --branch "${BRANCH}" -- "file://${BARE_FOLDER}" "${TEMP_FOLDER}"

    # Build to the destination folder
    hugo --quiet ${HUGO_ARGUMENTS} -b "${BASE_URL}/${BRANCH}" -s "${TEMP_FOLDER}" -d "${TARGET_FOLDER}/${BRANCH}"

    # Cleanup the temp folder
    rm -rf "${TEMP_FOLDER}"
done

# Build the index page
INDEX_PAGE="${TARGET_FOLDER}/index.html"

echo -e "<h1>Branches</h1>\n<ul>" > "${INDEX_PAGE}"
for BRANCH in $BRANCHES; do
    echo "  <li><a href=\"/${BRANCH}\">${BRANCH}</a></li>" >> "${INDEX_PAGE}"
done
echo -e "</ul>\n<p>Last Updated: $(date)</p>" >> "${INDEX_PAGE}"

# Remove bare repo
rm -rf "${BARE_FOLDER}"