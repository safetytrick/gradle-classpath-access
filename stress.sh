#!/usr/bin/env bash

set -e
set -o pipefail

iteration=0

while ./gradlew assemble --info --stacktrace | tee output.txt; do
  echo "another success"
  mv output.txt output.old.txt

let iteration++

cat << EOF > "common/src/main/resources/iter-${iteration}.properties"
iteration=$iteration
EOF

cat << EOF > "common/src/main/resources/current.properties"
iteration=$iteration
EOF


done

