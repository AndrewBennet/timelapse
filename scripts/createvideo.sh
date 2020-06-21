#!/bin/bash
set -e

PHOTO_DIR=/home/pi/Desktop/timelapse_photos
VIDEO_DIR=/home/pi/Desktop/timelapse_videos
FULL_TIMELAPSE=$VIDEO_DIR/full_timelapse.avi

# Get yesterday's date
YESTERDAY=$(date -d "yesterday 13:00" '+%Y-%m-%d')
ls $PHOTO_DIR/$YESTERDAY*.jpg > $YESTERDAY.txt

# Create AVI video from yesterday's photos
mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1280:720 -o $VIDEO_DIR/$YESTERDAY.avi -mf type=jpeg:fps=25 mf://@$YESTERDAY.txt
echo "Timelapse video created"

# Delete the original images
echo "Deleting source photos..."
rm $YESTERDAY.txt
rm $PHOTO_DIR/$YESTERDAY*.jpg

# Concat this video onto existing video - if we have the full video
if ls "${FULL_TIMELAPSE}"; then
    echo "Joining new timelapse onto existing timelapse video"
    TEMP_FULL_TIMELAPSE=$VIDEO_DIR/full_timelapse_temp.avi
    mencoder -oac copy -ovc copy $FULL_TIMELAPSE $VIDEO_DIR/$YESTERDAY.avi -o $TEMP_FULL_TIMELAPSE
    
    rm $FULL_TIMELAPSE
    mv $TEMP_FULL_TIMELAPSE $FULL_TIMELAPSE
    echo "Completed."
else
    mv $VIDEO_DIR/$YESTEDAY.avi $FULL_TIMELAPSE
    echo "No existing full timelapse video: now created."
fi