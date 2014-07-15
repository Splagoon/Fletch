#!/bin/bash

# Thanks to Kevin Moore (http://work.j832.com/) for this script

# bail on error
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

BROWSER_TEST_FILE=$DIR/../test/test.html

echo Running against test file at:
echo $BROWSER_TEST_FILE

DUMP=$(content_shell --args --dump-render-tree $BROWSER_TEST_FILE)
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