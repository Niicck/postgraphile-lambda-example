#!/bin/bash
# set -e

rm -f build/graphql.zip
cd dist
find . -type f  -not -name '*.js.map' | zip -Xqr@ ../build/graphql.zip
