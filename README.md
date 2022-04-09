Dotfiles
========

This repo contains dotfiles written for Homenet machines

This repo uses stow to install and handle all dotfile sym-links. Stow should be
installed on your machine, and this repo should be cloned 1 dir under where
these dotfiles should be installed. (Likely in a .dotfiles dir in $HOME).

Running the install.sh script will install all desired dotfiles based
upon the contents of the STOW_FOLDERS env variable. This variable
should hold a space separated list of folders from this repo. All
dotfiles in those folders, including subfolders will be installed.
