<html>
  <head>
    <link rel="stylesheet" href="website/main.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>

  <body>
    <h1>Timelapse Cam</h1>
    <h2>Raspberry Pi Zero</h2>
    <div>
      <div>
        <?php
          $files = scandir('timelapse_photos', SCANDIR_SORT_DESCENDING);
          $newest_file = $files[0];
          echo "<div>Latest Photo Timestamp: " . $newest_file . "</div>";
          echo "<img src=\"./timelapse_photos/" . $newest_file . "\"/>";
        ?>
        <div>
          <?php
            $videos = scandir('timelapse_videos', SCANDIR_SORT_DESCENDING);
            $newest_video = $videos[0];
            echo "<a href=\"./timelapse_videos/" . $newest_video . "\"/>Download Video</a>";
          ?>
          <a href="./timelapse_photos">See All Photos</a>
        </div>
      </div>
      <div>
        <h3>
          Raspberry Pi Stats:
        </h3>
        <span>
          Disk space remaining: 
          <?php
            echo floor(disk_free_space("/") / (1024 * 1024));
          ?>
          MB
        </span>
      </div>

  </body>

</html>
