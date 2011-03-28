<?php
#var_dump($_SERVER);
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'init.php');
$page = new Page(LONG_COMPANY_NAME,'8');

$query = "SELECT `image`,`col1`,`col2` FROM `about` LIMIT 1";
$result = queryDb($query,$db_connection);
while($row = mysql_fetch_assoc($result))
{
	$page->addHTML('<img src="' . DS . IMG_DIR . DS . $row['image'] . '"/>');
	$page->addHTML('<div id="aboutcopyshell">');
	$page->addHTML('<p class="aboutCopy marginR20">' . nl2br($row['col1']) . '</p>');
	$page->addHTML('<p class="aboutCopy">' . nl2br($row['col2']) . '</p>');
	$page->addHTML('</div>');
}
$page->dump();
?>
