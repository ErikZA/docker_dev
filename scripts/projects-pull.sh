#!/bin/bash

read -p "Press [Enter] key to start pulling..."

dir=${PWD}

for file in "$dir/"*
do
  if [ -d "$file" ]; then
    echo "$file"
	  cd "$file"
	  git fetch --prune && git pull && clear
  fi
done
