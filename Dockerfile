FROM node:10.14.2-alpine as base

LABEL "com.github.actions.name"="Vuepress deploy"
LABEL "com.github.actions.description"="A GitHub Action to build and deploy Vuepress sites to GitHub Pages"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/luo-zn/vuepress-deploy.git"
LABEL "homepage"="https://github.com/luo-zn/vuepress-deploy.git"
LABEL "maintainer"="lzn <jannanlo@163.com>"

RUN apk add --no-cache git jq && npm install -g vuepress

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]