# Assign script directory depending on the shell type (bash or zsh)
if [ -n "$BASH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
elif [ -n "$ZSH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${(%):-%N}" )" >/dev/null 2>&1 && pwd )"
else
    echo "Unknown shell type"
    exit 1
fi


os_type="$(uname -s)"

if [[ "$os_type" == "Darwin" ]]; then
	source "$SCRIPT_DIR/macOS/profile.sh"
else
	source "$SCRIPT_DIR/debian/profile.sh"
fi
