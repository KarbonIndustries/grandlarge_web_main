<?php

# HTML FUNCTIONS


# SESSION FUNCTIONS
function startSession()
{
	session_start();
}

function loggedIn()
{
	return isset($_SESSION['username']);
}

function confirmLoggedIn()
{
	if(!loggedIn())
	{
		redirectTo('index.php');
	}
}

# GENERAL FUNCTIONS
function redirectTo($url = NULL)
{
	if(isset($url))
	{
		header("Location: {$url}");
		exit;
	}
}

# GENERAL DB FUNCTIONS
function connectDb()
{
	$dbLink = mysql_connect(DB_HOST,DB_USER,DB_PASS);
	if(!$dbLink)
	{
		die('DB Connection Error: ' . mysql_error());
	}
	return $dbLink;
}

function closeDb($db)
{
	mysql_close($db);
}

function useDb($dbName,$link)
{
	$db = mysql_select_db($dbName,$link);
	if(!$db)
	{
		die('DB Selection Error: ' . mysql_error());
	}
	return $db;
}

function mysqlClean($value)
{
	$value = trim($value);
	$magicQuotesOn = get_magic_quotes_gpc();
	$validPHPVersion = function_exists("mysql_real_escape_string"); // php >= v4.3.0
	if($validPHPVersion)
	{
		if($magicQuotesOn)
		{
			$value = stripslashes($value);
		}
		$value = mysql_real_escape_string($value);
	}else
	{
		if(!$magicQuotesOn)
		{
			$value = addslashes($value);
		}
	}
	return $value;
}

function queryDb($query)
{
	$result = mysql_query($query);
	confirmQuery($result);
	return $result;
}

function confirmQuery($result)
{
	if(!$result)
	{
		die('error ' . mysql_error());
	}
}

function getNav()
{
	global $db_connection;
	$query = "SELECT `navigation`.* FROM `navigation` ORDER BY `navigation`.`id` ASC";
	$result = queryDb($query,$db_connection);
	$nav = array();
	while($row = mysql_fetch_assoc($result))
	{
		$nav[] = strtoupper($row['name']);
	}
	return $nav;
}

function getSubNav($catId)
{
	$catId > 6 || $catId < 2 ? exit : null;
	global $db_connection;
	$query = "SELECT `mediaFeeds`.`feedURL`,`directors`.`firstName`,`directors`.`lastName`,`mediaFeeds`.`mediaCategoryID`,`mediaFeeds`.`id` ";
	$query .= "FROM `mediaFeeds` ";
	$query .= "INNER JOIN `directors` ";
	$query .= "ON `mediaFeeds`.`directorID` = `directors`.`id` ";
	$query .= "WHERE `mediaFeeds`.`mediaCategoryID` = " . $catId . " AND `directors`.`active` = 1 ";
	$query .= "ORDER BY `mediaFeeds`.`categoryPosition` ASC";
	$result = queryDb($query,$db_connection);
	$subNav = array();
	while($row = mysql_fetch_assoc($result))
	{
		$subNav[] = array('name' => $row['firstName'] . ' ' . $row['lastName'],'url' => $row['feedURL'],'cat' => $row['mediaCategoryID'],'id' => $row['id']);
	}
	return $subNav;
}

function getDirById($id)
{
	global $db_connection;
	$query = "SELECT `mediaFeeds`.*,`directors`.* ";
	$query .= "FROM `mediaFeeds` ";
	$query .= "LEFT JOIN `directors` ";
	$query .= "ON `mediaFeeds`.`directorID` = `directors`.`id` ";
	$query .= "WHERE `mediaFeeds`.`id` = " . $id . " ";
	$query .= "LIMIT 1";
	$result = queryDb($query,$db_connection);
	$dir = mysql_fetch_assoc($result);
	return $dir;
}

function getDirectors()
{
	global $db_connection;
	$query = "";
	$query .= "SELECT `directors`.`id`,`directors`.`firstName`,`directors`.`lastName` ";
	$query .= "FROM `directors` ";
	$query .= "WHERE `directors`.`active` = 1 ";
	$query .= "ORDER BY `directors`.`firstName`";
	$result = queryDb($query,$db_connection);
	while($row = mysql_fetch_assoc($result))
	{
		$dir[] = $row;
	}
	return $dir;
}

?>