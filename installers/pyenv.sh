#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Pre-set to avoid interactive prompt from tzdata apt package
sudo ln -fs /usr/share/zoneinfo/US/Central /etc/localtime

# Via https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev

# Via https://github.com/pyenv/pyenv-installer
set +u
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
set -u

source "${HOME}/.profile-extensions/pyenv.sh"

# Install python versions
pyenv install $(latest_python2_stable)
pyenv install $(latest_python3_stable)
