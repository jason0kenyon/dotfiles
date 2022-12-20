#!/bin/bash

# specify directory where main notes stay
DIR=$HOME/projects/org/org-roam/daily

#specify where fleeting notes go to die
ARCH_DIR=$HOME/projects/org/daily

#check if roam daily directory nonempty, and if so, move its contents to the archive
if [ "$(ls -A  $DIR)" ]; then
for file in $DIR/* ; do
  mv "$file" "$ARCH_DIR"
done
fi

#check if roam daily directory nonempty, and if so, the remove remaining dailies
if [ "$(ls -A  $DIR)" ]; then
for file in $DIR ; do
  rm "$file"
done
fi

