#!/usr/bin/env bash
mkdir -p snapshots
if ! grep -q "^/snapshots$" .gitignore 2>/dev/null; then
  echo "/snapshots" >> .gitignore
  echo "Added /snapshots to .gitignore"
fi

echo "Setup complete. Start your AI and feed BOOTSTRAP.txt"
