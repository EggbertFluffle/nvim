#!/bin/bash

pwd
echo "-------------------------------"
ghci $1 -Wno-tabs
# cabal repl
echo "-------------------------------"
bash
