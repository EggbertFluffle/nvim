#!/bin/bash

pwd
echo "-------------------------------"
if [ -f "./gradlew" ]; then
	ls
	# ./gradlew runClient
else
	echo "There is nothing to run"
fi
echo "-------------------------------"
bash
