#!/bin/bash

# Set the repository URL and local directory
REPO_URL=https://github.com/maticnetwork/avail.git
LOCAL_DIR=/avail/repo

# Fetch the latest changes from the repository
cd $LOCAL_DIR
git fetch

# Check if there are any new commits
NEW_COMMITS=$(git log HEAD..origin/main --oneline)

# If there are new commits, build the binary and restart the service
if [ -n "$NEW_COMMITS" ]; then
  git pull
  /root/.cargo/bin/cargo build -r -p data-avail
  cp ./target/release/data-avail /usr/bin/data-avail
  systemctl restart avail-node
fi