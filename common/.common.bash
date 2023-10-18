# Assign script directory depending on the shell type (bash or zsh)
if [ -n "$BASH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
elif [ -n "$ZSH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${(%):-%N}" )" >/dev/null 2>&1 && pwd )"
else
    echo "Unknown shell type"
    exit 1
fi

# Bash aliases helpers
alias l='ls'
alias ll='ls -lh'

# Directory jump with Z Shell, taken from https://github.com/rupa/z
. ${SCRIPT_DIR}/z/z.sh

# Utilities
source ${SCRIPT_DIR}/.git.bash

# Python Functions
function jupyter-kernel-install() {
  python -m ipykernel install --user --name=$1
}