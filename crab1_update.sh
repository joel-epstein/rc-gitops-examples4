#!/bin/sh  
while true  
do  
  sed -i '' 's/REDLIGHT/GREENLIGHT/g' greymatter/projectwaldo/crab1.cue
  git add greymatter/projectwaldo/crab1.cue 
  git commit -m "change description to GREENLIGHT" 
  git push
  sleep $((15 + RANDOM % 21))
  sed -i '' 's/GREENLIGHT/REDLIGHT/g' greymatter/projectwaldo/crab1.cue
  git add greymatter/projectwaldo/crab1.cue
  git commit -m "change description to REDLIGHT"                  
  git push
  sleep $((15 + RANDOM % 21))
done
