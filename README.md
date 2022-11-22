# Advent of Code 2022

The purpose of this repo is to test modern perl development methods

## Directory Structure

### bin

Executable script(s) to get the answer for the days puzzle.  bin scripts should be kept thin, actual logic is inside the pm file(s).  To run do so from the root dir so that the use lib path works eg `./bin/day_01.pl`.

### lib

Contains perl modules that perform the necessary operations to solve the puzzle.  Modules should be responsible for doing 1 "thing".  They should also be fully covered by unit tests.

### t

Contains unit tests, test files correspond to pm files in the lib directory.  To run the tests, from the root of the project run `yath test`

## Test Coverage

To check the test coverage, from the root of the project run `cover -t +select ^lib +ignore ^ -make 'prove -Ilib -r t; exit $?'`

## Static Code Analysis

TODO