#!/bin/bash

# Get /app/public and /app/storage catalogs from image
docker rm -f laravel-prod
docker run -d -v $(pwd)/tmp:/tmp --name laravel-prod laravel-prod
docker exec -i laravel-prod mkdir /tmp/app
docker exec -i laravel-prod cp -R /app/storage /tmp/app
docker exec -i laravel-prod cp -R /app/public /tmp/app
docker rm -f laravel-prod
mv $(pwd)/tmp/app .
chmod -R a+rw app
rm -r tmp
docker run -d -v $(pwd)/app:/app --name laravel-prod laravel-prod
docker exec -i laravel-prod chown -R www-data:www-data /app/storage /app/public
docker exec -i laravel-prod chmod -R a+rw /app/storage
docker rm -f laravel-prod
