#!/usr/bin/env sh

set -o errexit      # (-e) exit immediately when a command fails
set -o nounset      # (-u) treat unset variables as an error and exit immediately
# set -o errtrace     # (-E) inherit custom signal traps
set -o pipefail     # set status code to the last failed command in a pipe if any
# set -o xtrace       # (-x) print each command before executing it


readonly GH_TOKEN="${INPUT_TOKEN}"
readonly SOURCE_DIRECTORY="${INPUT_SOURCEDIRECTORY}"

readonly GH_USER="${INPUT_ACTOR:-"${GITHUB_ACTOR}"}"
readonly GH_REPOSITORY="${INPUT_REPO:-"${GITHUB_REPOSITORY}"}"
readonly GH_BRANCH="${INPUT_TARGETBRANCH:-"gh-pages"}"
readonly GH_PAGES_FQDN="${INPUT_FQDN:-""}"

readonly WORK_DIR="$(mktemp -d -p .)"

# TODO(crash5): push with keep history
# git worktree add --force -B ${WORK_DIR##*/} ${WORK_DIR}
# git checkout --orphan=gh-pages
# git rm -rf .

cp -R "${SOURCE_DIRECTORY}/." "${WORK_DIR}"

# Set pages FQDN if present
[[ -n "${GH_PAGES_FQDN}" ]] && echo "${GH_PAGES_FQDN}" > "${WORK_DIR}/CNAME"


cd "${WORK_DIR}"

git init
git config user.name "${GH_USER}"
git config user.email "${GH_USER}@users.noreply.github.com"

git add .
git commit --all --message "Automatic deploy"
git push --force --quiet "https://${GH_USER}:${GH_TOKEN}@github.com/${GH_REPOSITORY}.git" "HEAD:${GH_BRANCH}"
