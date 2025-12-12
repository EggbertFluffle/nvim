#!/bin/bash

pwd
echo "-------------------------------"
if [ -f "build.zig" ]; then
	zig build run
else
	zig run $1
fi
echo "-------------------------------"
bash
