<html>
  <head>
    <link rel="stylesheet" href="website/main.css">
  </head>

  <body>
    <h1>Timelapse Cam</h1>
    <div>
      <a href="./timelapse_photos">All Photos</a>
      <div>
<?php
$files = scandir('timelapse_photos', SCANDIR_SORT_DESCENDING);
$newest_file = $files[0];
echo "<img width=\"600\" src=\"./timelapse_photos/" . $newest_file . "\"/>";
echo "<div>" . $newest_file . "</div>";

$videos = scandir('timelapse_videos', SCANDIR_SORT_DESCENDING);
$newest_video = $videos[0];
echo "<video src=\"./timelapse_videos/" . $newest_video . "\"/>";
?>
      </div>

  </body>

</html>