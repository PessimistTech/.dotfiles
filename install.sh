#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then 
	ln -sf gitlab/jwilson/dotfiles/.vimrc ~/.vimrc
	ln -sf gitlab/jwilson/dotfiles/.tmux.conf ~/.tmux.conf
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then 
	ln -rsf .vimrc ~/.vimrc
	ln -rsf .tmux.conf ~/.tmux.conf
fi
