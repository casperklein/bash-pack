#!/bin/bash

set -ueo pipefail

cd "$(dirname "$(readlink -f "$0")")"

git log --graph --decorate --abbrev-commit --all --pretty=oneline
