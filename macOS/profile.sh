# Assign script directory depending on the shell type (bash or zsh)
if [ -n "$BASH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    # Bash prompt settings
    export PS1="\u:\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --bash)"
elif [ -n "$ZSH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${(%):-%N}" )" >/dev/null 2>&1 && pwd )"

    # Load the Version Control System info module
    autoload -Uz vcs_info
    precmd() { vcs_info }

    # Format the git output (Coloring the branch cyan)
    zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'

    # Zsh prompt settings
    setopt PROMPT_SUBST
    PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ${vcs_info_msg_0_}%# '

    # Set up fzf key bindings and fuzzy completion
    source <(fzf --zsh)
else
    echo "Unknown shell type"
    exit 1
fi

# Color listing outputs
export CLICOLOR=1
export LSCOLORS="dxfxcxdxbxegedabagacad"

# Homebrew
export PATH=$PATH:/usr/local/bin:/opt/homebrew/bin

# Brew bash completion - installed via brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Source common bash utilities
source ${SCRIPT_DIR}/../common/common.sh