#!/bin/bash

# Thanks to Kevin Moore (http://work.j832.com/) for this script

# bail on error
set -e

# Download & install content_shell if not found
which content_shell
if [[ $? -ne 0 ]]; then
  $DART_SDK/../chromium/download_contentshell.sh
  unzip content_shell-linux-x64-release.zip

  cs_path=$(ls -d drt-*)
  PATH=$cs_path:$PATH
fi

DUMP=$(content_shell --dump-render-tree test/test.html)
echo "$DUMP"

REGEX="All [0-9]+ tests pass"

if [[ $DUMP =~ $REGEX ]]
then
  echo Success!
  exit 0
else
  echo Fail!
  exit 1
fi