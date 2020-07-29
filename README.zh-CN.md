[English](./README.md) | 简体中文

# vuepress-deploy :computer:

GitHub Action组件，用于自动构建、部署vuepress项目到Github Pages

## 先决条件 :clipboard:

### 创建 access token

1. 点击账号头像
2. 点击 Settings
3. 点击 Developer settings
4. 点击 Personal access tokens
5. 点击 Generate new token

更多信息: [accss token](https://help.github.com/en/github/authenticating-to-github/authorizing-a-personal-access-token-for-use-with-saml-single-sign-on)

### 创建 github secrets

1. 进入当前项目仓库
2. 点击 Settings
3. 点击 Secrets
4. 在名字框输入ACCESS_TOKEN， 在值框输入刚才创建的accss token值

更多信息:[create secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)

## 用法 :hammer:

在当前项目仓库的.github/workflows目录下创建一个xxxx.yml文件，如：vuepress-deploy.yml。

```yml
name: Build and Deploy
on: [push]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master

    - name: vuepress build and deploy
      uses: luo-zn/vuepress-deploy@master
      env:
        ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        TARGET_REPO: username/repo_name
        TARGET_BRANCH: master
        BUILD_SCRIPT: vuepress build blog # or yarn && yarn build
        BUILD_DIR: blog/.vuepress/dist
```

## 参数 :postbox:

|  Parameter |  Description | Type | Required
| :------------ | :------------ |:------------ |:------------ |
| `ACCESS_TOKEN` | github的access token | `secrets`  |  **Yes** |
| `TARGET_REPO` | 目标仓库，如：`luo-zn/blog`. 默认值当前仓库 | `env` | **No** |
| `TARGET_BRANCH` | 目标仓库的分支，如：`gh-pages`.默认值gh-pages | `env` | **No** |
| `TARGET_LINK` | 目标仓库的完整链接，用于其他平台，
如:`https://user:${{ secrets.CODING_TOKEN }}@gitlab.coding.come/org/repo.git`. | `env` | **No** |
| `BUILD_SCRIPT` | 构建vuepress项目的命令脚本。如: `yarn && yarn build` | `env` | **Yes** |
| `BUILD_DIR` | 构建完成后的输出目录。如: `blog/.vuepress/dist/` | `env` | **Yes** |
| `CNAME` | Github Pages站点别名。 | `env` | **no** |

备注: 如果当前仓库是github用户名所有的仓库，github pages只能从master分支的源码构建。
