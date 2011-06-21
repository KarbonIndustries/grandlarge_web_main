<?php
#var_dump($_SERVER);
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'init.php');
$page = new Page(LONG_COMPANY_NAME,'9');
$db_connection = connectDb();
$db = useDb(DB_NAME,$db_connection);
$query =	"SELECT `contacts`.*,`officeCategories`.`name` AS `categoryName`,`states`.`abbreviation` AS `state` ";
$query .= 	"FROM `contacts` ";
$query .=	"INNER JOIN `officeCategories` ";
$query .=	"ON `contacts`.`officeCategoryID` = `officeCategories`.`id` ";
$query .=	"INNER JOIN `states` ";
$query .=	"ON `contacts`.`stateID` = `states`.`id` ";
$query .=	"ORDER BY `officeCategories`.`name` ASC,`contacts`.`officeLocale` ASC";
$result = queryDb($query,$db_connection);
$locale = '';
$divInit = false;
$divFirst = '<div class="contactSetFirst">';
$div = '<div class="contactSet">';
$colCount;
while($row = mysql_fetch_assoc($result))
{
	if($row['categoryName'] !== $locale)
	{
		$page->addHTML($divInit ? $div . "\n" . '<h3 class="contactCategory">' . strtoupper($row['categoryName']) . '</h3>': $divFirst . "\n" . '<h3 class="contactCategory">' . strtoupper($row['categoryName']) . '</h3>');
		$divInit = true;
		$colCount = 0;
		echo 'S<br />';
	}
		if($colCount % 4 === 0 || $row['categoryName'] !== $locale)
		{
			$page->addHTML('<div style="float:left;">');
			echo 'row<br />';
		}
				echo 'ul<br />';
				$page->addHTML('<ul>');
					$page->addHTML('<li>' . $row['officeLocale'] . '</li>');
					$page->addHTML('<li class="contactInfo">' . $row['companyName'] . '</li>');
					!empty($row['address1']) ? $page->addHTML('<li class="contactInfo">' . $row['address1'] . '</li>') : NULL;
					!empty($row['address2']) ? $page->addHTML('<li class="contactInfo">' . $row['address2'] . '</li>') : NULL;
					!empty($row['address3']) ? $page->addHTML('<li class="contactInfo">' . $row['address3'] . '</li>') : NULL;
					if(!empty($row['country']))
					{
						if(!empty($row['state']))
						{
							$page->addHTML('<li class="contactInfo">' . $row['city'] . ', ' . $row['state'] . ' ' . $row['zip'] . ' ' . $row['country'] . '</li>');
						}else
						{
							$page->addHTML('<li class="contactInfo">' . $row['zip'] . ' ' . $row['city'] . ', ' . $row['country'] . '</li>');
						}
					}
					!empty($row['contact1FirstName']) ? $page->addHTML('<li class="contactInfo">' . $row['contact1FirstName'] . ' ' . $row['contact1LastName'] . '</li>') : NULL;
					!empty($row['contact2FirstName']) ? $page->addHTML('<li class="contactInfo">' . $row['contact2FirstName'] . ' ' . $row['contact2LastName'] . '</li>') : NULL;
					!empty($row['contact3FirstName']) ? $page->addHTML('<li class="contactInfo">' . $row['contact3FirstName'] . ' ' . $row['contact3LastName'] . '</li>') : NULL;
					!empty($row['phone']) ? $page->addHTML('<li class="contactInfo"><span class="contactHighlight">' . PHONE_ABBR . ' </span>' . $row['phone'] . '</li>') : NULL;
					!empty($row['websiteURL']) ? $page->addHTML('<li class="contactInfo"><span class="contactHighlight">' . WEB_ABBR . ' </span><a href="' . (strripos($row['websiteURL'],'http://') === false ? 'http://' . $row['websiteURL'] : $row['websiteURL']) . '" target="_blank">' . $row['websiteURL'] . '</a></li>') : NULL;
					!empty($row['email']) ? $page->addHTML('<li class="contactInfo"><span class="contactHighlight">' . EMAIL_ABBR . ' </span><a href="mailto:' . $row['email'] . '">' . $row['email'] . '</a></li>') : NULL;
				$page->addHTML('</ul>',false);
				echo 'ul close<br />';
				$colCount++;
		if($colCount % 4 === 0 || $row['categoryName'] !== $locale)
		{
			$page->addHTML('</div>');
			echo 'row end<br />';
		}
	
	$locale = $row['categoryName'];
	if($row['categoryName'] !== $locale)
	{
		$page->addHTML('</div>',false);
		echo 'S end<br />';
	}
}
$page->dump();
?>