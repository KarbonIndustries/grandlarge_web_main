<?php
header('Content-type: text/css');
require_once($_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'inc' . DIRECTORY_SEPARATOR . 'init.php');

#CONSTANTS
define('CONTENT_WIDTH',960);

#VARIABLES
$colors = array(
	'GL_BLUE'	=>	'#65A7C0',
	'GREY1'		=>	'#1F1F1F',
	'GREY2'		=>	'#424242',
	'BLACK'		=>	'#000000',
	'WHITE'		=>	'#FFFFFF'
);

$fontSet1 = array(
	'lucidaGrande'	=>	'"Lucida Grande"',
	'lucidaSans'	=>	'"Lucida Sans Unicode"',
	'arial'			=>	'Arial',
	'verdana'		=>	'Verdana',
	'sans'			=>	'sans-serif'
);
?>
/***************
GLOBAL STYLES
***************/
body,html{
margin:0px;
padding:0px;
background:<?=$colors['BLACK']?>;
font-family:<?=implode(",",$fontSet1)?>;
font-size:14px;
color:<?=$colors['WHITE']?>;
}

a{text-decoration:none;color:<?=$colors['WHITE']?>;}
a:focus{outline:<?=$colors['GREY1']?> dotted 1px;}
img{border:none;display:block;}
ul{list-style:none outside;margin:0;padding:0;}

#outerShell{width:<?=CONTENT_WIDTH?>px;margin:0px auto;}

/**************
HOME LINK
**************/
#homeLink{margin:25px 0 24px 0;}
#homeLink>a>img{width:440px;}


/**************
NAVIGATION
**************/
#navShell{float:left;width:<?=CONTENT_WIDTH?>px;margin-bottom:67px;}
ul#nav{list-style:none outside;margin:0;padding:0;}
ul#nav>li{display:inline;*position:relative;}
ul#nav>li:hover ul{display:block;}
ul#nav>li:hover a{background-color:<?=$colors['GL_BLUE']?>;cursor:pointer;}
ul#nav>li>a.selected{background-color:<?=$colors['GL_BLUE']?>;}
a.navItem{margin:0;padding:5px 15px;float:left;color:<?=$colors['WHITE']?>;}
a.navItemSelected{margin:0;padding:5px 15px;float:left;color:<?=$colors['WHITE']?>;background-color:<?=$colors['GL_BLUE']?>;}
#subNavShell{width:<?=CONTENT_WIDTH - 20?>px;background-color:<?=$colors['GL_BLUE']?>;padding:10px;position:absolute;top:151px;*top:27px;*left:-920px;display:none;list-style:none outside;}
/*#subNavShell li{float:left;margin-bottom:4px;margin-right:10px;width:164px;}*/
#subNavShell li{float:left;margin-bottom:4px;margin-right:30px;}
#subNavShell a{color:<?=$colors['WHITE']?>;}
#subNavShell a:hover{text-decoration:underline;}

/**************
CONTENT
**************/
#contentShell{display:block;clear:both;margin-bottom:100px;padding:0px;float:left;width:960px;}
.newsShell1{background:<?=$colors['GL_BLUE']?>;float:left;margin:0 5px 5px 0;}
.newsShell2{background:<?=$colors['GL_BLUE']?>;float:left;margin:0 0 5px 0;}
.newsShell1>p,.newsShell2>p{font-size:12px;margin:0;padding:8px;}
div.contactSetFirst{float:left;}
div.contactSet{margin-top:36px;float:left;}
div.contactSetFirst,div.contactSet{width:100%;}
div.contactSet ul,div.contactSetFirst ul{width:236px;margin-right:10px;float:left;}
div.contactSet li,div.contactSetFirst li{line-height:18px;}
h3.contactCategory{color:<?=$colors['GL_BLUE']?>;margin:0 0 10px;}
.contactHighlight{color:<?=$colors['GL_BLUE']?>;}
.contactInfo{color:<?=$colors['GREY2']?>;}
li.contactInfo a{color:<?=$colors['GREY2']?>;}
li.contactInfo a:hover{color:<?=$colors['GL_BLUE']?>;}
div#aboutcopyshell{margin-top:10px;}
p.aboutCopy{margin-right:20px;width:460px;float:left;line-height:20px;}
#directorInfo a{background:<?=$colors['GL_BLUE']?> url('<?=DS . IMG_DIR . DS?>dir_url_arrow.png') no-repeat 95% center;padding:7px 29px 7px 15px;color:<?=$colors['BLACK']?>;}
#directorInfo p{margin-bottom:33px;width:628px;line-height:1.6em;}
/**************
FOOTER
**************/
#footerShell{display:block;clear:both;border-top:1px solid <?=$colors['WHITE']?>;color:<?=$colors['GL_BLUE']?>;font-size:11px;margin-bottom:50px;padding:14px 0;}
#footerLeft{float:left;}
#footerRight{float:right;}
#footerShell a{color:<?=$colors['GL_BLUE']?>;}