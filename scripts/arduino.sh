#!/bin/bash

pwd
echo "-------------------------------"
arduino-cli compile -b arduino:avr:uno /home/eggbert/programs/arduino/VCA_Percussion/src/VCA_Percussion_Lab/ --upload --port /dev/ttyACM0
minicom --device /dev/ttyACM0 --baudrate 19200
echo "-------------------------------"
bash
