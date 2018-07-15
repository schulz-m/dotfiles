SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Homebrew
export PATH=/usr/local/bin:$PATH

# Git completion
if [ -f ${SCRIPT_DIR}/.git-completion.bash ]; then
  . ${SCRIPT_DIR}/.git-completion.bash
fi

# Z shell load
. ${SCRIPT_DIR}/../.bash/z.sh

# gRPC Helpers
python_proto() {
    python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. $1
}

# Bash aliases helpers
alias l='ls'
alias ll='ls -l'

alias note_done='terminal-notifier -message Finito'

# GIT Helpers
git_notrack() {
    git branch -vv | awk '/: gone]/{print $1}'
}

export GITAWAREPROMPT=${SCRIPT_DIR}/../.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

alias git_tree='git log --graph --oneline --all --decorate'

# Bash prompt settings
export PS1="\u:\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u[$txtrst\] \w\$ "