#!/bin/bash
# pwd | sed 's/ /\\ \\/g
# '| sed 's/\=/\\=/' | sed 's/)/\\)/g' | cd; unzip *.zip -d .
dir=$(echo $1 | sed 's/\=/\\=/g' | sed 's/)/\\)/g' | sed 's/ /\\ \\/g')
echo $dir
echo 'ready to run'
echo -----
mdir=$(echo $2 | sed 's/\=/\\=/g' | sed 's/)/\\)/g' | sed 's/ /\\ \\/g')
echo ------
echo mdir is: $mdir

echo -------
echo first arg: $dir , second dir: $mdir
echo ------
eval unzip $dir -d $mdir
rm -r *.zip


