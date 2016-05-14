#!/bin/bash

# get the path to this script
thisScriptsPath=$(cd $(dirname $0); pwd -P)

sourcePath=$thisScriptsPath/bin
destPath=$HOME/bin
backupPath=$1

# if the destination file already exists
if [[ -e $destPath ]]; then
  # if the destination file isn't linked to the dotfiles
  if [[ $(readlink -f $destPath) != $sourcePath ]]; then
    # std output
    echo "Backing up $destPath to $backupPath"

    # create the backup dir
    mkdir -p $backupPath

    # create a backup of the old dotfile
    cp -r $destPath $backupPath
  fi

  # std output
  echo "Removing the old dotfile $destPath"

  # now that it's backed-up, delete it
  rm -r $destPath
fi

# std output
echo "linking $destPath->$sourcePath"

# link the dotfile
ln -s $sourcePath $destPath
