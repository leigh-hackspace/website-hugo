#!/bin/bash
# Deploys the retro version of the website. Ran the same way as the branch deploy.
set -u

TARGET_FOLDER=$(realpath $1)
BASE_URL="$2"

# Arguments to add to the Hugo call
HUGO_ARGUMENTS="--gc"

# Pull the updates and run Hugo
git pull
hugo --quiet ${HUGO_ARGUMENTS} -b "${BASE_URL}" -d "${TARGET_FOLDER}" -t "lhs-retro"
