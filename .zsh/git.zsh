function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status --short --branch
  fi
}

function gc {
  if [[ $# > 0 ]]; then
    git commit --message $1
  else
    git commit --verbose
  fi
}

function gf {
  if [[ $# > 0 ]]; then
    git diff-tree --no-commit-id --name-only -r $@
  else
    git diff-tree --no-commit-id --name-only -r HEAD
  fi
}
