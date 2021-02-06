# Contributing Guide

Thanks for being willing to contribute!

- [Contributing Guide](#contributing-guide)
  - [Commit Message Convention](#commit-message-convention)
  - [Project setup](#project-setup)
  - [Tests](#tests)
  - [Style](#style)
  - [Run Demo](#run-demo)
  - [Help needed](#help-needed)

## Commit Message Convention

Commits should follow the [Conventional Commits spec](https://conventionalcommits.org/).

## Project setup

1. Fork and clone the repo
2. `bundle install` to install dependencies
3. Create a branch for your PR

> Tip: Keep your `main` branch pointing at the original repository and make
> pull requests from branches on your fork. To do this, run:
>
> ```
> git remote add upstream https://github.com/bt-rb/this-project
> git fetch upstream
> git branch --set-upstream-to=upstream/main main
> ```
>
> This will add the original repository as a "remote" called "upstream," Then
> fetch the git information from that remote, then set your local `main`
> branch to use the upstream main branch whenever you run `git pull`. Then you
> can make all of your pull request branches based on this `main` branch.
> Whenever you want to update your version of `main`, do a regular `git pull`.

## Tests

Run the tests:

```sh
rake
```

## Style

Run the linter:

```sh
bin/lint
```

Run the formatter:

```sh
bin/format
```

## Run Demo

```sh
cd demo
bundle
bundle exec bridgetown serve
```

Open up [localhost:4000](http://localhost:4000) in your browser.

## Release

Releases are handled automatically via GitHub Actions.

Release locally:

```sh
rake release
```

## Help needed

Please checkout the the open issues.

Also, please watch the repo and respond to questions/bug reports/feature
requests!

Thanks!
