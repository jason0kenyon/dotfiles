#! /bin/bash
if [ -d "$HOME/.config" ] ; then
  echo -e "Found $HOME/.config directory\nCreating symlinks"
  for file in $HOME/dotfiles/.config/* ; do
    echo -e "linking $file"
    ln -s "$file" "$HOME/.config/"
  done
fi

if [ -d "$HOME/.dotfiles" ] ; then 
  echo -e "$HOME/.dotfiles exists\n"
  echo -e "I can't create symlinks because your $HOME/.dotfiles directory exists"
  echo -e "Replacing $HOME/.dotfiles"
  rm -rf "$HOME/.dotfiles"
fi
mkdir "$HOME/.dotfiles"
echo -e "created .dotfiles directory\n"
echo -e "creating symlinks for dotfiles\n"
for file in $HOME/dotfiles/.config/* ; do
  echo -e "linking $file"
  ln -s "$file" "$HOME/.dotfiles/"
done
if [ "$XDG_CONFIG_HOME" != "$HOME/.dotfiles" ] ; then
  echo "export XDG_CONFIG_HOME=$HOME/.dotfiles" >> "$HOME/.bashrc" ; echo "export XDG_CONFIG_HOME=$HOME/.dotfiles" >> "$HOME/.zshrc"
  source "$HOME/.bashrc" ; source "$HOME/.zshrc"
  echo -e "I changed XDG_CONFIG_HOME to $XDG_CONFIG_HOME\n"
fi

echo "success\nnew variable appended to your bashrc and zshrc"
