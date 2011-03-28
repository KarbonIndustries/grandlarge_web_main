<?php
$imgURL = isset($_POST['imgURL']) ? $_POST['imgURL'] : NULL;
$handle = fopen($imgURL, 'rb');
$contents = stream_get_contents($handle);
header('Content-Type: image/jpeg');
echo $contents;
fclose($handle);
exit;
?>