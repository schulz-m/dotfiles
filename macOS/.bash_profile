SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Homebrew
export PATH=/usr/local/bin:$PATH

# Git completion
if [ -f ${SCRIPT_DIR}/.git-completion.bash ]; then
  . ${SCRIPT_DIR}/.git-completion.bash
fi

python_proto() {
    python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. $1
}

alias note_done='terminal-notifier -message Finito'

# Bash prompt settings
export PS1="\u:\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u[$txtrst\] \w\$ "

# Source common bash utilities
source ${SCRIPT_DIR}/../common/.common.bash