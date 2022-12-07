#!/bin/bash

# This script uses greymatter init to generate 50-100-150 services and
# introduce them into a single project scoped to a single namespace
# Once these cue files (kiwi_1.cue, kiwi_2.cue, etc.) are introduced
# they need to be grouped for the eval within EXPORTS.cue
# kiwi peach orange fig grape

for i in {1..10}
do
#echo "kiwi${i}"
# ~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "kiwi${i}"
~/greymatter-fix-deletes init service --insecure --type=http --dir greymatter/foobar_2 --port=9090 --namespace=foobar-2 "peach${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "orange${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "fig${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "grape${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "melon${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "cranberry${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "star${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "tangerine${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "blueberry${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "salmon${i}"
#~/greymatter init service --insecure --type=http --dir greymatter/projectwaldo --port=9090 --namespace=foobar- "crab${i}"





done

