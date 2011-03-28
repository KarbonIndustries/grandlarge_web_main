<?php
#var_dump($_SERVER);
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'init.php');
$page = new Page(LONG_COMPANY_NAME,isset($_GET['p']) ? ((int) $_GET['p'] < 7 ? $_GET['p'] : 1) : 1);
if(isset($_GET['id']))
{
	$dir = getDirById($_GET['id']);
	$page->setTitle(LONG_COMPANY_NAME . ' :: ' . $dir['firstName'] . ' ' . $dir['lastName']);
}else
{
	$dir = getDirById(1);
}
$dir = isset($_GET['id']) ? getDirById($_GET['id']) : getDirById(1);
$script1 = '<script type="text/javascript">' . "\n";
$script1 .= 'var feed = "' . $dir['feedURL'] . '";' . "\n";
#$script1 .= 'window.onload = initShowreel;' . "\n";
$script1 .= '</script>';

$page->addScript($script1);
$page->showPlayer = true;
$page->addHTML('<div id="directorInfo">');
!empty($dir['bio']) ? $page->addHTML('<p>' . nl2br($dir['bio']) . '</p>') : null;
!empty($dir['websiteURL']) ? $page->addHTML('<a href="' . $dir['websiteURL'] . '" target="_blank">visit ' . $dir['firstName'] . ' ' . $dir['lastName'] . (preg_match('/s$/',$dir['lastName']) ? '\'' : '\'s') . ' website</a>') : null;
$page->addHTML('</div>');
$page->dump();
?>