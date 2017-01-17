#!/bin/bash
#!/usr/local/bin/zsh

# gets hashcode for a string

STRING=$1
CHARS=`echo $STRING | fold -w1`

h=0

for c in $CHARS; do 
  a=$(printf "%d" "'$c")
  h=$((31 * $h + $a))
done

echo `expr $h % 255`

