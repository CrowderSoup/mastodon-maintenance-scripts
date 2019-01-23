#!/bin/bash

##############################################################################
# This script should be run manually. If anything goes wrong your mastodon   #
# instance will be left in a bad state, and you'll have to manually recover. #
##############################################################################

# Pull the most recent changes
git pull

# Build the new stuff
docker-compose build

# Run pre-deployment db migrations
docker-compose run --rm -e SKIP_POST_DEPLOYMENT_MIGRATIONS=true web rails db:migrate

# Restart Docker containers
docker restart $(docker ps -a -q)

# Run post-deployment migrations
docker-compose run --rm web rails db:migrate

# Restart Docker containers again
docker restart $(docker ps -a -q)
