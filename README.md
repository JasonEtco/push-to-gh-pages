<h3 align="center">Push to GitHub Pages</h3>
<p align="center">A GitHub Action that pushes a directory to the <code>gh-pages</code> branch.<p>

## Usage

This action pushes a directory of your project to the `gh-pages` branch, effectively deploying your site to GitHub Pages.

One example workflow is to automatically build and deploy your site whenever changes are made to the `master` branch:

```workflow
workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = [ "Deploy" ]
}

action "Default Branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Install dependencies" {
  needs = [ "Default Branch" ]
  uses = "actions/npm@master"
  args = "install"
}

action "Build" {
  needs = [ "Install dependencies" ]
  uses = "actions/npm@master"
  args = "run build"
}

action "Deploy" {
  needs = [ "Build" ]
  uses = "JasonEtco/upload-to-gh-pages@master"
  secrets = ["GITHUB_TOKEN"]
  args = "public"
}

```

## Requirements

You must pass at least one argument, the path to the directory you want to push. This is usually the output folder of a static site generator. If you want it to be the current directory, just pass `.`. You must also include the `GITHUB_TOKEN` secret, otherwise the Action won't be able to push to the branch.

```workflow
action "Deploy" {
  uses = "JasonEtco/push-to-gh-pages@master"
  args = "_site"
  secrets = ["GITHUB_TOKEN"]
}
```