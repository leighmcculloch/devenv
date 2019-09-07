#! /usr/bin/env zsh

# Only run if we're inside a tmux session
if [ -z "$TMUX" ]; then
  exit 0
fi

# Only run once
if [ -f "$HOME/.firstrundone" ]; then
  exit 0
fi
touch "$HOME/.firstrundone"

# Collect user info
echo 'Collecting user info...'
name=$(git config --global user.name)
email=$(git config --global user.email)
vared -p 'Name: ' -c name
vared -p 'Email: ' -c email

# Generate key for user
echo 'Generating gpg key...'
gpg --batch --quick-generate-key "$name <$email>" future-default default 1w
gpg --armor --export "$name <$email>"

# Configure user
git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.signingkey "$name"
git config --global commit.gpgsign true

# Setup ssh key in agent
echo 'Adding ssh key...'
ssh-add
