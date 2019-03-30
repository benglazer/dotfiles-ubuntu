#!/bin/bash

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev  # via https://github.com/pyenv/pyenv/wiki/Common-build-problems
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash  # via https://github.com/pyenv/pyenv-installer

source "${HOME}/.profile-extensions/pyenv.sh"
pyenv install $(latest_python2_stable)
pyenv install $(latest_python3_stable)
