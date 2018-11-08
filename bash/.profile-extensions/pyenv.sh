#!/bin/bash

if [ -x ~/.pyenv/libexec/pyenv ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
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
    envname=${1:-$(basename $(pwd))}
    (pyenv virtualenv $(latest_python3_stable) $envname) && (echo $envname > .python-version)
}
