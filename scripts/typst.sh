#!/bin/bash

pwd
typst watch $1 &
echo "-------------------------------"
zathura $(echo $1 | sed 's/typ/pdf/g') &
echo "-------------------------------"
bash
