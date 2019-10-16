#!/bin/bash

# GIT Helpers
function git_notrack {
     git branch -vv | awk '{print $1, $4}' | grep 'gone]' | awk '{print $1}'
}

function git_clean {
	git fetch origin
	git remote prune origin
	DEAD_BRANCHES="$(git_notrack)"
	if test -z "$DEAD_BRANCHES"
	then
		echo "No branches found to clean"
    else
    	echo "Deleting dead branches: $DEAD_BRANCHES"
    	git branch -D $DEAD_BRANCHES
    fi
}

export GITAWAREPROMPT=${SCRIPT_DIR}/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

alias git_tree='git log --graph --oneline --all --decorate'
alias git_submodule_update='git submodule update --init --recursive && git submodule update --recursive'