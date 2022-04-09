#!/bin/zsh

for folder in $(echo $STOW_FOLDERS)
do 
	stow -D $folder
	stow $folder
done
