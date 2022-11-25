#!/bin/bash

# This script uses greymatter init to generate 50-100-150 services and
# introduce them into a single project scoped to a single namespace
# Once these cue files (kiwi_1.cue, kiwi_2.cue, etc.) are introduced
# they need to be grouped for the eval within EXPORTS.cue
# kiwi peach orange fig grape

for i in {1..2}
do
#echo "kiwi${i}"
# ~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "kiwi${i}"
~/greymatter453 init service --insecure --type=http --dir greymatter/foobar_2 --port=9090 --namespace=foobar-2 "peach${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "orange${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "fig${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "grape${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "melon${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "cranberry${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "star${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "tangerine${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "blueberry${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "salmon${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --package=projectwaldo "crab${i}"





done

