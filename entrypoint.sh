#!/bin/sh
#Create By lzn

set -e

function build_script(){
  if [[ -z $BUILD_SCRIPT ]];then
    # default BUILD_SCRIPT
    BUILD_SCRIPT="vuepress build ."
  fi
  echo -e "==> Start building \n building scripts: $BUILD_SCRIPT"
  eval "$BUILD_SCRIPT"
}

function cd_build_dir(){
  echo "==> Changing directory to '$BUILD_DIR' ..."
  cd $BUILD_DIR
}

function get_respository(){
  if [[ -z "$TARGET_REPO" ]]; then
    REPOSITORY_NAME="${GITHUB_REPOSITORY}"
  else
    REPOSITORY_NAME="$TARGET_REPO"
  fi
}
function get_branch(){
  if [[ -z "$TARGET_BRANCH" ]]; then
    DEPLOY_BRAN="gh-pages"
  else
    DEPLOY_BRAN="$TARGET_BRANCH"
  fi
}
function set_deploy_repo(){
  get_respository

  DEPLOY_REPO="https://${ACCESS_TOKEN}@github.com/${REPOSITORY_NAME}.git"
  if [ "$TARGET_LINK" ]; then
    DEPLOY_REPO="$TARGET_LINK"
  fi
}

function generate_cname_file(){
  if [ "$CNAME" ]; then
    echo "Generating a CNAME file..."
    echo $CNAME > CNAME
  fi
}

function main(){
  build_script
  cd_build_dir
  set_deploy_repo

  echo "==> Prepare to deploy ${TARGET_BRANCH}"
  echo "==> BUILD_DIR=${BUILD_DIR}"
  pwd
  git config --global --add safe.directory /github/workspace/lznSite/.vuepress/dist
  git init  
  git branch -m "${TARGET_BRANCH}"
  git config user.name "${GITHUB_ACTOR}"
  git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"  
  if [ -z "$(git status --porcelain)" ]; then
      echo "The BUILD_DIR is setting error or nothing produced" && \
      echo "Exiting..."
      exit 0
  fi
  generate_cname_file
  echo "==> Starting deploying"
  get_branch

  git add .
  git commit -m 'Auto deploy from Github Actions'
  git push --force $DEPLOY_REPO master:$DEPLOY_BRAN
  rm -fr .git
  cd $GITHUB_WORKSPACE
  echo "Successfully deployed!" && \
  echo "See: https://github.com/$REPOSITORY_NAME/tree/$DEPLOY_BRAN"
}

main "$*"
