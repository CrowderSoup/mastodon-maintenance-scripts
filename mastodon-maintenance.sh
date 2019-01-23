#!/bin/bash

# Clean up media files
docker-compose run --rm web ./bin/tootctl media remove --background

# Clean up remote accouts
docker-compose run --rm web ./bin/tootctl accounts cull
