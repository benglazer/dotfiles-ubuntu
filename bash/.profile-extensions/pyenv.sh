#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [[ -x ~/.pyenv/libexec/pyenv ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    set +u
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    set -u
fi

# Custom functions

latest_python_stable() {
    pyenv install -l | sed -nr 's/^  ([\.0-9]+)$/\1/p' | tail -n 1
}

latest_python2_stable() {
    pyenv install -l | sed -nr 's/^  (2\.[\.0-9]+)$/\1/p' | tail -n 1
}

latest_python3_stable() {
    pyenv install -l | sed -nr 's/^  (3\.[\.0-9]+)$/\1/p' | tail -n 1
}

mkvenvhere() {
    env_name=${1:-$(basename $(pwd))}
    (pyenv virtualenv $(latest_python3_stable) "$env_name") && (echo "$env_name" > .python-version)
}
