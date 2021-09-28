#!/usr/bin/env bash

set -e
set -o pipefail

iteration=0

function doIteration() {
  cat << EOF > "common/src/main/resources/iter-${1}.properties"
iteration=$1
EOF

  cat << EOF > "common/src/main/resources/current.properties"
iteration=$1
EOF

}

doIteration 0

while ./gradlew assemble -Piteration=$iteration --info --stacktrace | tee output.txt; do

  let iteration=iteration+1
  doIteration $iteration

done



