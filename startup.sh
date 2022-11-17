#! /bin/bash

#check for .dotfiles directory and replace if necessary
if [ -d "$HOME/.dotfiles" ] ; then
  echo -e "can't create symlinks because your $HOME/.dotfiles directory exists"
  echo -e "Replacing $HOME/.dotfiles\n"
  rm -rf "$HOME/.dotfiles"
fi
mkdir "$HOME/.dotfiles"
echo -e "created .dotfiles directory\n"
echo -e "creating symlinks for dotfiles\n"

#creat symlinks to .dotfiles from dotfiles source
for file in $HOME/dotfiles/.config/* ; do
  echo -e "linking $file"
  ln -s "$file" "$HOME/.dotfiles/"
done
echo -e "\n"

#link all files in .dotfiles not included in XDG_CONFIG_HOME (some programs do not permit this. or maybe you don't want to use it for some reason.)
for file in $HOME/dotfiles/.*; do
  if [ -f "$file" ] ; then
    ln -s "$file" "$HOME"
  fi
done

#set XDG_CONFIG_HOME variable so programs know where to look for config (zsh and bash only)
if [ "$XDG_CONFIG_HOME" != "$HOME/.dotfiles" ] ; then
  echo "export XDG_CONFIG_HOME=$HOME/.dotfiles" >> "$HOME/.bashrc" ; echo "export XDG_CONFIG_HOME=$HOME/.dotfiles" >> "$HOME/.zshrc"
  source "$HOME/.bashrc" ; source "$HOME/.zshrc"
  echo -e "I changed XDG_CONFIG_HOME to $XDG_CONFIG_HOME\n"
fi

echo -e "\nsuccess\nnew variable appended to your bashrc and zshrc"
