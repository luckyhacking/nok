#!/bin/sh

# from https://github.com/razeencheng/git-hooks

set -e

_green() {
  printf '\033[1;31;32m%b\033[0m\n' "$1"
}

_red() {
  printf '\033[1;31;40m%b\033[0m\n' "$1"
}

_exists() {
  cmd="$1"
  if [ -z "$cmd" ]; then
    _red "Usage: _exists cmd"
    return 1
  fi

  if eval type type >/dev/null 2>&1; then
    eval type "$cmd" >/dev/null 2>&1
  elif command >/dev/null 2>&1; then
    command -v "$cmd" >/dev/null 2>&1
  else
    which "$cmd" >/dev/null 2>&1
  fi
  return "$?"
}

main() {
  if [ "$(uname -s)" != "Darwin" ]; then
    _red "Unsupported operating system, Darwin?";
    return 1;
  fi

  if [ ! -d ".git" ]; then 
    _red "Dir .git not find, Please git init first?";
    return 1;
  fi

  if [ -f .git/hooks/commit-msg ]; then
    mv .git/hooks/commit-msg .git/hooks/commit-msg.bak;
  fi

  curl https://gist.githubusercontent.com/luckyhacking/6e54d459674f2b73f51dc41a782ae02a/raw/68560f71f5463958cf34089a269ccbef3280274f/git-commit-msg.sh -o .git/hooks/commit-msg

  chmod +x .git/hooks/commit-msg

  _green "commit-msg hook Install Success!"
}

main "$@"
