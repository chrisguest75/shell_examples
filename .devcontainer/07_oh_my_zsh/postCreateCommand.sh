#!/bin/bash/env bash
echo "Executing postCreateCommand.sh"
echo "uname: $(uname -a)"
echo "whoami: $(whoami)"

sed -i.bak "s/ZSH_THEME=\"codespaces\"/ZSH_THEME=\"robbyrussell\"/g" /root/.zshrc
sed -i.bak "s/ZSH_THEME=\"codespaces\"/ZSH_THEME=\"robbyrussell\"/g" ~/.zshrc

