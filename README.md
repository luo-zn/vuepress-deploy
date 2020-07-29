# vuepress-deploy

A GitHub Action to build and deploy Vuepress sites to GitHub Pages

## Prerequisite

### Create a personal access token

1. click your profile
2. Click Settings
3. Developer settings
4. Personal access tokens
5. Generate new token

more infomation: [accss token](https://help.github.com/en/github/authenticating-to-github/authorizing-a-personal-access-token-for-use-with-saml-single-sign-on)

### Creating encrypted secrets

1. enter repository 
2. click Settings
3. Secrets 
4. input ACCESS_TOKEN in then name box and the accss token value

more infomation:[create secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)

## Usage

Create vuepress-deploy.yml in .github/workflows directory in the root of the repository.

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

## Parameters

|  Parameter |  Description | Type | Required
| :------------ | :------------ |:------------ |:------------ |
| `ACCESS_TOKEN` | Personal access token | `secrets`  |  **Yes** |
| `TARGET_REPO` | The repository you want to deploy. e.g.:`luo-zn/blog`. Default: **current repository** | `env` | **No** |
| `TARGET_BRANCH` | The branch you want to deploy. e.g.:`gh-pages`.Default: **gh-pages** | `env` | **No** |
| `TARGET_LINK` | The full address of the target repo will cover `TARGET_REPO` for other platforms. e.g.:`https://user:${{ secrets.CODING_TOKEN }}@team.coding.net/team/repo.git`. | `env` | **No** |
| `BUILD_SCRIPT` | The script to build the vuepress project. e.g.: `yarn && yarn build` | `env` | **Yes** |
| `BUILD_DIR` | The output of the build-script above. e.g.: `blog/.vuepress/dist/` | `env` | **Yes** |
| `CNAME` | Alias Record of your site. | `env` | **no** |

