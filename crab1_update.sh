#!/bin/sh  
while true  
do  
  sed -i '' 's/REDLIGHT/GREENLIGHT/g' greymatter/projectwaldo/kiwi1.cue
  git add greymatter/projectwaldo/kiwi1.cue 
  git commit -m "change description to GREENLIGHT" 
  git push
  sleep $((15 + RANDOM % 3))
  sed -i '' 's/GREENLIGHT/REDLIGHT/g' greymatter/projectwaldo/kiwi1.cue
  git add greymatter/projectwaldo/kiwi1.cue
  git commit -m "change description to REDLIGHT"                  
  git push
  sleep $((15 + RANDOM % 3))
done
