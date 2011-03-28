<?php
#var_dump($_SERVER);
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'init.php');
$page = new Page(LONG_COMPANY_NAME,'7');
$db_connection = connectDb();
$db = useDb(DB_NAME,$db_connection);
$query = "SELECT `title`,`image`,`desc`,`url` FROM `news` ORDER BY `timeAdded` DESC";
$result = queryDb($query,$db_connection);
$count = 0;
while($row = mysql_fetch_assoc($result))
{
	$count++;
	$page->addHTML('<div class="newsShell' . ($count % 5 == 0 ? '2' : '1') . '"><a href="' . $row['url'] . '" target="_blank"><img src="' . DS . IMG_DIR . DS . NOTABLE_DIR . DS . $row['image'] . '"/></a><p><a href="' . $row['url'] . '" target="_blank">' . $row['desc'] . '</a></p></div>',false);
}
$page->dump();
?>
