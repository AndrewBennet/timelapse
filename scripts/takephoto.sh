#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
raspistill -o /home/pi/Desktop/timelapse_photos/$DATE.jpg