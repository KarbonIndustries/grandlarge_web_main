<?php
#error_reporting(0);
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'config.php');
require_once(INC_DIR . 'db.php');
require_once(INC_DIR . 'functions.php');

$db_connection = connectDb();
$db = useDb(DB_NAME,$db_connection);

function __autoload($class_name)
{
		$file1 = INC_DIR . $class_name . '.php';
		$file2 = CLASS_DIR . $class_name . '.php';
		$file3 = FLOURISH_DIR . $class_name . '.php';

		if(file_exists($file1))
		{
			include $file1;
			return;
		}
		if(file_exists($file2))
		{
			include $file2;
			return;
		}
		if(file_exists($file3))
		{
			include $file3;
			return;
		}

		throw new Exception('The class ' . $class_name . ' could not be loaded');
}

?>