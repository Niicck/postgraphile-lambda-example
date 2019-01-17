#!/bin/bash

export SLS_DEBUG=*
CURRENT_DIR=`dirname $BASH_SOURCE`

echo "Sourcing environment"
if [ -x .env ]; then
  . ./.env
  echo "... done"
else
  echo "... no .env file found"
fi

if [ "$DATABASE_URL" = "" ]; then
  echo "No DATABASE_URL envvar found; cannot continue."
  exit 1
fi

echo "Create Package"
sls package -p build -v

yarn build-serverless

echo "Create S3 Bucket"
node scripts/createS3Bucket.js

serverless deploy -p build -v
