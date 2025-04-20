#!/bin/bash

# Script to sync .devcontainer folder from main branch to all other branches
# Ensure you run this script from the root of your Git repository

set -e  # Exit immediately if a command exits with a non-zero status

# Step 1: Ensure you are on the main branch
echo "Switching to the main branch..."
git checkout main

# Step 2: Commit the .devcontainer changes if not already committed
echo "Committing .devcontainer folder if there are any changes..."
git add .devcontainer/ || true
git commit -m "Add/update .devcontainer configuration for Elixir setup" || echo "No changes to commit on main branch."

# Step 3: Push the changes to the remote repository
echo "Pushing changes to the main branch..."
git push origin main

# Step 4: Loop through all other branches and update the .devcontainer folder
echo "Syncing .devcontainer folder to other branches..."
for branch in $(git branch -r | grep -v '\->' | grep -v 'main' | sed 's|origin/||'); do
  echo "Processing branch: $branch..."
  git checkout $branch
  git checkout main -- .devcontainer/  # Copy the .devcontainer folder from main
  git add .devcontainer/ || true
  git commit -m "Sync .devcontainer configuration from main branch" || echo "No changes to commit on $branch."
  git push origin $branch
done

# Step 5: Return to the main branch
echo "Returning to the main branch..."
git checkout main

echo "Done! The .devcontainer folder has been synced to all branches."