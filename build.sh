#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
MIX_ENV=prod mix assets.deploy
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite