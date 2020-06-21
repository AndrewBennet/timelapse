#!/bin/bash

DATE=$(date +"%Y-%m-%d")
ls /home/pi/Desktop/timelapse_photos/$DATE*.jpg > $DATE.txt

mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1280:720 -o /home/pi/Desktop/timelapse_videos/$DATE.avi -mf type=jpeg:fps=25 mf://@$DATE.txt

rm $DATE.txt