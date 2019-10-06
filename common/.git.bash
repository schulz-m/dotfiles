# GIT Helpers
git_notrack() {
    git branch -vv | awk '/: gone]/{print $1}'
}

export GITAWAREPROMPT=${SCRIPT_DIR}/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

alias git_tree='git log --graph --oneline --all --decorate'