#!/bin/bash

function init {
  if [[ "$SNAPSHOT_BROWSER" == "" ]]; then
    export SNAPSHOT_BROWSER=chrome
    export SNAPSHOT_BROWSER_ID=chrome_desktop_test
    export SNAPSHOT_WIDTH=400
    export SNAPSHOT_HEIGHT=800
    export SNAPSHOT_TEST_ID=$RANDOM
  fi
}

function run {
  cd ../..

  export SNAPSHOT_TEST_ID=$(git rev-parse HEAD)
  export SAUCE_TUNNEL_ID=$CIRCLE_BUILD_DUM
  export SAUCE_BUILD_ID=$CIRCLE_SHA1

  echo "CIRCLE_BUILD_NUM=$CIRCLE_BUILD_NUM"
  echo "CIRCLE_SHA1=$CIRCLE_SHA1"

  gulp demos --demo-version=nightly

  gulp snapshot-sauce \
    --browser "$SNAPSHOT_BROWSER" \
    --params.platform_id="$SNAPSHOT_BROWSER_ID" \
    --params.width="$SNAPSHOT_WIDTH" \
    --params.height="$SNAPSHOT_HEIGHT" \
    --params.test_id="$SNAPSHOT_TEST_ID"
}

source $(dirname $0)/../utils.inc