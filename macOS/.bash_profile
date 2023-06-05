SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Homebrew
export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin

# Git completion (Doesn't work anymore? maxOS Big Sur)
# if [ -f ${SCRIPT_DIR}/.git-completion.bash ]; then
#   . ${SCRIPT_DIR}/.git-completion.bash
# fi

# Brew bash completion - installed via brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
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