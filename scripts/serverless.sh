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

mkdir $CURRENT_DIR/../cache
mkdir $CURRENT_DIR/../dist

echo "Generate cache"
scripts/generate-cache

echo "Create S3 Bucket"
node scripts/createS3Bucket.js

echo "Deploy"
sls deploy -v
