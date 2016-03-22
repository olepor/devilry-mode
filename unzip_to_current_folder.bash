#!/bin/bash
# pwd | sed 's/ /\\ \\/g
# '| sed 's/\=/\\=/' | sed 's/)/\\)/g' | cd; unzip *.zip -d .
dir=$1
echo $dir
echo 'ready to run'
output=$(${dir} | sed 's/ /\\ \\/g
'| sed 's/\=/\\=/' | sed 's/)/\\)/g' | cd; unzip *.zip -d .)
echo $output
