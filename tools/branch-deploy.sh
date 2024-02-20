#!/bin/bash
# Deploys all branches of a Hugo repository to a structure of folders.
# Useful for deploying all PRs/branches of a Hugo installation to a test URL for viewing.
set -u

# Args: folder, baseurl
TARGET_FOLDER=$(realpath $1)
BASE_URL="$2"

# Arguments to add to the Hugo call
HUGO_ARGUMENTS="--gc -D -F"

# Themes to build instances of
THEMES="lhs lhs-retro"

# Ensure the target folder exists
mkdir -p "${TARGET_FOLDER}"

# Clear out target folder, and put a boilerplate index in while we're building
rm -rf ${TARGET_FOLDER}/*
INDEX_PAGE="${TARGET_FOLDER}/index.html"
echo "<meta http-equiv="refresh" content="5"><p>Deploying...</p>" > "${INDEX_PAGE}"

# Create a block all robots.txt
echo -e "User-agent: *\nDisallow: /" > "${TARGET_FOLDER}/robots.txt"

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
    for THEME in $THEMES; do
        mkdir -p "${TARGET_FOLDER}/${BRANCH}/${THEME}"
    done
    TEMP_FOLDER=`mktemp -u -d`

    # Checkout the branch
    git clone -q --branch "${BRANCH}" -- "file://${BARE_FOLDER}" "${TEMP_FOLDER}"

    # Build to the destination folder
    for THEME in $THEMES; do
        hugo --quiet ${HUGO_ARGUMENTS} -b "${BASE_URL}/${BRANCH}/${THEME}" -s "${TEMP_FOLDER}" -d "${TARGET_FOLDER}/${BRANCH}/${THEME}" -t "${THEME}"
        find "${TARGET_FOLDER}/${BRANCH}/${THEME}" -name "*.cgi" -exec chmod a+x {}\;
    done

    # Cleanup the temp folder
    rm -rf "${TEMP_FOLDER}"
done

# Build the full index page
echo -e "<h1>Branches</h1>\n<ul>" > "${INDEX_PAGE}"
for BRANCH in $BRANCHES; do
    echo "  <li>${BRANCH} - " >> "${INDEX_PAGE}"
    for THEME in $THEMES; do
        echo "<a href=\"/${BRANCH}/${THEME}\">${THEME}</a> " >> "${INDEX_PAGE}"
    done
    echo "</li>" >> "${INDEX_PAGE}"
done
echo -e "</ul>\n<p>Last Updated: $(date)</p>" >> "${INDEX_PAGE}"

# Remove bare repo
rm -rf "${BARE_FOLDER}"