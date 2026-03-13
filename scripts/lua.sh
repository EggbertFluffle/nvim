#!/bin/bash

pwd
echo "-------------------------------"

# lua $1
cd /home/eggbert/programs/zig/mezzaluna/ && zig build run
# love .

echo "-------------------------------"
bash
