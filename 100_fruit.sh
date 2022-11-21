#!/bin/bash

# This script uses greymatter init to generate 1000 services and
# introduce them into a single project scoped to a single namespace
# Once these cue files (kiwi_1.cue, kiwi_2.cue, etc.) are introduced
# they need to be grouped for the eval within EXPORTS.cue
# kiwi peach orange fig grape

for i in {1..150}
do
#echo "kiwi${i}"
greymatter init service --insecure --type=http --dir greymatter/grocerylist --port=9090 --package=grocerylist "kiwi-${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/grocerylist --port=3000 --package=grocerylist "peach-${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/grocerylist --port=3000 --package=grocerylist "orange-${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/grocerylist --port=3000 --package=grocerylist "fig-${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/grocerylist --port=3000 --package=grocerylist "grape-${i}"
done

