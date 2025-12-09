#!/bin/bash
#
# Alias setup for common commands.
# To activate, run: source alias_setup.sh
#

# Alias 'cls' to run the 'clear' command, providing a familiar
# screen-clearing command for users coming from DOS/Windows environments.
alias cls='clear'
echo "Alias 'cls' is now configured to run 'clear'."

# Docker alias

alias dh-ps='docker ps -a'
alias dh-i='docker images'
alias dh-logs='docker logs --tail 50'
alias dh-reload='sudo systemctl restart docker.service && echo "Docker daemon reloaded."'

echo "Docker alias added"

# code editor

alias cedit='/data/v3/bin/vscode/v1.106/code --wait'
export EDITOR='cedit'
echo "Code editor configured"
