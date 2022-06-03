#!/bin/bash

read -p "Press [Enter] key to continue compilation..."

dir=${PWD}

for file in "$dir/"*
do
  if [ -d "$file" ]; then
	cd "$file"
	find;
  fi
done

read -p "Press [Enter] key to start backup..."
