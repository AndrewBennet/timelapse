#!/bin/bash
set -e

PHOTO_DIR=/home/pi/Desktop/timelapse_photos
VIDEO_DIR=/home/pi/Desktop/timelapse_videos
FULL_TIMELAPSE=$VIDEO_DIR/full_timelapse.avi

TODAY=$(date '+%Y-%m-%d')
ls $PHOTO_DIR/$TODAY*.jpg > $TODAY.txt

# Create AVI video from yesterday's photos
mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1280:720 -o $VIDEO_DIR/$TODAY.avi -mf type=jpeg:fps=25 mf://@$TODAY.txt
echo "Timelapse video created"

# Delete the original images
echo "Deleting source photos..."
rm $TODAY.txt
rm $PHOTO_DIR/$TODAY*.jpg

# Concat this video onto existing video - if we have the full video
if ls "${FULL_TIMELAPSE}"; then
    echo "Joining new timelapse onto existing timelapse video"
    TEMP_FULL_TIMELAPSE=$VIDEO_DIR/full_timelapse_temp.avi
    mencoder -oac copy -ovc copy $FULL_TIMELAPSE $VIDEO_DIR/$TODAY.avi -o $TEMP_FULL_TIMELAPSE
    
    rm $FULL_TIMELAPSE
    mv $TEMP_FULL_TIMELAPSE $FULL_TIMELAPSE

    rm $VIDEO_DIR/$TODAY.avi
    echo "Completed."
else
    mv $VIDEO_DIR/$TODAY.avi $FULL_TIMELAPSE
    echo "No existing full timelapse video: now created."
fi