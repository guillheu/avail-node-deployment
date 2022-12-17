#!/bin/bash

# Set the repository URL and local directory
REPO_URL=https://github.com/maticnetwork/avail.git
LOCAL_DIR=/avail/repo

# Fetch the latest changes from the repository

echo "Fetching Avail node updates from $REPO_URL"

cd $LOCAL_DIR
git fetch

# Check if there are any new commits
echo "Checking for new commits on the main branch..."
NEW_COMMITS=$(git log HEAD..origin/main --oneline)

# If there are new commits, build the binary and restart the service
if [ -n "$NEW_COMMITS" ]; then
  echo "New commit(s) found. pulling..."
  git pull
  echo "building node binary..."
  /root/.cargo/bin/cargo build -r -p data-avail
  echo "copying newly built node binary to /usr/bin/data-avail..."
  cp ./target/release/data-avail /usr/bin/data-avail
  echo "restarting avail-node service..."
  systemctl restart avail-node
fi
echo "All done. See you in a minute."