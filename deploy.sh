#!/bin/bash

# --- CONFIGURATION ---
REPO_NAME="VSCodium-Mastery-Guide"
COMMIT_MESSAGE="Initial commit: VSCodium Mastery Guide summary"
BRANCH_NAME="main"

echo "Starting automated deployment for $REPO_NAME..."
echo "---------------------------------------"

# 1. INITIALIZE LOCAL REPOSITORY
git init -b $BRANCH_NAME
echo "✅ Local Git repository initialized."

# 2. STAGE AND COMMIT FILES
git add .
git commit -m "$COMMIT_MESSAGE"
echo "✅ Files staged and committed."

# 3. CREATE REMOTE REPO AND LINK (GH CLI Practice)
# Creates a public repo on GitHub and sets the remote origin URL to SSH
gh repo create "$REPO_NAME" --public --remote=origin
if [ $? -eq 0 ]; then
    echo "✅ Remote repository created and linked via SSH."
else
    echo "❌ Error creating remote repository. Check gh auth status."
    exit 1
fi

# 4. PUSH TO GITHUB (SSH Authentication)
git push -u origin $BRANCH_NAME
echo "✅ Local changes pushed to GitHub successfully!"

echo "---------------------------------------"
echo "Your guide is live: https://github.com/$(gh api user -q .login)/$REPO_NAME"