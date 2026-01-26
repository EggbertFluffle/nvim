#!/bin/bash

pwd
echo "-------------------------------"
# ghc --make main.hs -Wno-tabs
# ./main
# ghci ./main.hs -Wno-tabs
cabal repl
echo "-------------------------------"
bash
