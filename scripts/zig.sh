#!/bin/bash

pwd
echo "-------------------------------"
if [ -f "build.zig" ]; then
	zig build
else
	zig run $1
fi
echo "-------------------------------"
bash
