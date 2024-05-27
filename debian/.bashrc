# Custom bashrc loaded after system bash (usually in ~/.bashrc)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Source common bash utilities
source ${SCRIPT_DIR}/../common/.common.bash

# Update prompt
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Move hidden files by default
shopt -s dotglob

# Useful commands
## Command to show "N files" in current directory
find_files() {
    find . -maxdepth 1 -type f | tail -n "$1"
}
## Command to copy from one folder to the other with progress and statistics
alias dict_copy="time rsync -avh --info=progress2"
