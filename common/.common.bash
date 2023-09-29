SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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
