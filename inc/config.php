<?php
define('DS',DIRECTORY_SEPARATOR);
define('PD','..' . DS);
define('ROOT', $_SERVER['DOCUMENT_ROOT'] . DS);
define('INC_DIR',ROOT . PD . 'inc' . DS);
define('CLASS_DIR',ROOT . PD . 'inc' . DS . 'classes' . DS);
define('FLOURISH_DIR',CLASS_DIR . 'flourish' . DS);
define('STORAGE_DIR','storage');
define('FILE_DIR','files');
define('NOTABLE_DIR','notable');
define('CSS_DIR','css');
define('IMG_DIR','img');
define('JS_DIR','js');
define('SWF_DIR','swf');
define('SHORT_COMPANY_NAME','Grand Large');
define('LONG_COMPANY_NAME',SHORT_COMPANY_NAME . ' Inc.');
define('COMPANY_BASE_URL','http://www.grandlargeinc.com/');
define('ARCHITECT','Karbon Interaktiv Inc.');
define('ARCHITECT_URL','http://www.karbonnyc.com/');

define('PHONE_ABBR','T:');
define('WEB_ABBR','W:');
define('EMAIL_ABBR','E:');
?>