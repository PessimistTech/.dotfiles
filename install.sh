#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then 
	ln -sf gitlab/jwilson/dotfiles/dotfiles/.vimrc ~/.vimrc
	ln -sf gitlab/jwilson/dotfiles/dotfiles/.tmux.conf ~/.tmux.conf
	ln -sf gitlab/jwilson/dotfiles/dotfiles/.zshrc ~/.zshrc
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then 
	ln -rsf dotfiles/.vimrc ~/.vimrc
	ln -rsf dotfiles/.tmux.conf ~/.tmux.conf
	ln -rsf dotfiles/.zshrc ~/.zshrc
fi
