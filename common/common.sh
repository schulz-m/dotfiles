# Assign script directory depending on the shell type (bash or zsh)
if [ -n "$BASH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    alias source_shell="source ~/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${(%):-%N}" )" >/dev/null 2>&1 && pwd )"

    alias source_shell="source ~/.zshrc"
else
    echo "Unknown shell type"
    exit 1
fi

# Bash aliases helpers
alias l='ls'
alias ll='ls -lah --color=auto'
## Pretty print the PATH
alias path='echo; tr ":" "\n" <<< "$PATH"; echo;'

# Directory jump with Z Shell, taken from https://github.com/rupa/z
. ${SCRIPT_DIR}/z/z.sh

# Utilities
source ${SCRIPT_DIR}/git_functions.sh

copy_ssh_key() {
  # Check if a target was provided
  if [[ -z "$1" ]]; then
    echo "Usage: copy_ssh_key hostname_or_alias"
    return 1
  fi

  local target="$1"
  local pub_key_file=""

  # Look for standard public key formats in order of modern preference
  for key in ~/.ssh/id_{ed25519,rsa,ecdsa,dsa}.pub; do
    if [[ -f "$key" ]]; then
      pub_key_file="$key"
      break
    fi
  done

  # Exit if no key is found
  if [[ -z "$pub_key_file" ]]; then
    echo "Error: No public SSH key found in ~/.ssh/"
    echo "Generate one first using: ssh-keygen -t ed25519"
    return 1
  fi

  echo "🔑 Found key: $pub_key_file"
  echo "🚀 Copying to $target..."

  # Read the key, pipe it to the remote server, and safely append it to authorized_keys
  # It also ensures the correct restrictive permissions are set, which SSH requires.
  cat "$pub_key_file" | ssh "$target" '
    mkdir -p ~/.ssh && 
    chmod 700 ~/.ssh && 
    cat >> ~/.ssh/authorized_keys && 
    chmod 600 ~/.ssh/authorized_keys
  '

  if [[ $? -eq 0 ]]; then
    echo "✅ Success! You should now be able to log in without a password."
    echo "Try it: ssh $target"
  else
    echo "❌ Failed to copy the SSH key. Check your password and network connection."
  fi
}

# Sensible configurations
if [ ! -f "$HOME/.hushlogin" ]; then
    touch "$HOME/.hushlogin"
fi

# Python Functions
function jupyter-kernel-install() {
  python -m ipykernel install --user --name=$1
}