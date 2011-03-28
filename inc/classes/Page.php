<?php

class Page
{
	#VARIABLES
	private $title;
	private $content;
	private $meta = array();
	private $css = array();
	private $scripts = array();
	private $html;
	private $navItems = array();
	public $showPlayer = false;
	private $playerId = 'playerShell';
	private $playerWidth = 960;
	private $playerHeight = 710;
	private $dbLink;
	private $nav;
	private $subNav;

	public function __construct($title = 'page',$navSelect = NULL)
	{
		$this->nav = getNav();
		$this->subNav[] = getSubNav(2);
		$this->subNav[] = getSubNav(3);
		$this->subNav[] = getSubNav(4);
		$this->subNav[] = getSubNav(5);
		$this->subNav[] = getSubNav(6);
		$selected[1] = NULL;
		$selected[2] = NULL;
		$selected[3] = NULL;
		$selected[4] = NULL;
		$selected[5] = NULL;
		$selected[6] = NULL;
		$selected[7] = NULL;
		$selected[8] = NULL;
		$selected[9] = NULL;

		switch($navSelect)
		{
			case 1:
			$selected[1] = 'selected';
			break;
			case 2:
			$selected[2] = 'selected';
			break;
			case 3:
			$selected[3] = 'selected';
			break;
			case 4:
			$selected[4] = 'selected';
			break;
			case 5:
			$selected[5] = 'selected';
			break;
			case 6:
			$selected[6] = 'selected';
			break;
			case 7:
			$selected[7] = 'selected';
			break;
			case 8:
			$selected[8] = 'selected';
			break;
			case 9:
			$selected[9] = 'selected';
			break;
			default:
			break;
		}
		
		$this->setTitle($title);
		$this->addMeta('<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />');
		$this->addMeta('<meta name="author" content="' . ARCHITECT . '" />');
		$directorDb = getDirectors();
		foreach($directorDb as $index)
		{
			$directors[] = $index['firstName'] . (!empty($index['lastName']) ? ' ' . $index['lastName'] : '');
		}
		$this->addMeta('<meta name="keywords" content="Grand Large Inc,Steven Horton,commercials,production,advertising,international,music videos,new media,creative talent,' . implode(',',$directors) . '" />');
		$this->addmeta('<meta name="description" content="Featuring a diverse group of directors, Grand Large is known for its ability to deliver effective commercials, new media content and music videos." />');
		$this->addCSS(DS . CSS_DIR . DS . 'styles.php');

		$this->addScript('<script type="text/javascript" src="' . DS . JS_DIR . DS . 'gl_base.js"></script>');
		$glBase = '<script type="text/javascript">' . "\n";
		$glBase .= 'track();' . "\n";
		$glBase .= 'checkAgent("' . COMPANY_BASE_URL . '");' . "\n";
		$glBase .= '</script>';
		$this->addScript($glBase);

		$this->addNavItem(array_shift($this->nav),$selected[1],NULL,DS . '?p=1&id=1');
		foreach($this->subNav as $section)
		{
			$subNav = array();
/*
			foreach($section as $key => $value)
			{
				echo $key % 2;
				#$subNav[] = '<li><a href="' . DS . '?p=' . $item['cat'] . '&id=' . $item['id'] . '">' . $item['name'] . '</a></li>';
			}
*/
			foreach($section as $item)
			{
				$subNav[] = '<li><a href="' . DS . '?p=' . $item['cat'] . '&id=' . $item['id'] . '">' . $item['name'] . '</a></li>';
			}
			$this->addNavItem(array_shift($this->nav),$selected[$item['cat']],NULL,DS . '?p=' . $item['cat'] . '&id=' . $section[0]['id'],NULL,$subNav,'subNavShell','class');
		}
		$this->addNavItem(array_shift($this->nav),$selected[7],NULL,'notable.php');
		$this->addNavItem(array_shift($this->nav),$selected[8],NULL,'about.php');
		$this->addNavItem(array_shift($this->nav),$selected[9],NULL,'contact.php');
	}

	private function addContent($line,$return = true)
	{
		$this->content .= $line . ($return ? "\n" : '');
	}

	public function setTitle($title)
	{
		$this->title = $title;
	}

	public function addMeta($meta)
	{
		$this->meta[] = $meta;
	}

	public function addCSS($src,$type = "screen")
	{
		$this->css[] = '<link rel="stylesheet" href="' . $src . '" type="text/css" media="' . $type . '">';
	}

	public function addScript($script)
	{
		$this->scripts[] = $script;
	}

	public function addNavItem($item = 'NAV ITEM',$class = NULL,$id = NULL,$url = NULL,$js = NULL,$subNav = NULL,$subNavId = NULL,$subNavClass = NULL)
	{
		$item = '<li><a' . ($id ? ' id="' . $id . '"' : '') . ' class="navItem' . ($class ? ' ' . $class : '') . '"' . ($url ? ' href="' . $url . '"' : '') . ($js ? ' ' . $js : '') . '>' . $item . '</a>';
		if(is_array($subNav))
		{
			$item .= "\n" . '<ul';
			$item .= ($subNavId ? ' id="' . $subNavId . '"' : '');
			$item .= ($subNavClass ? ' class="' . $subNavClass . '"' : '');
			$item .= '>';
			$item .= "\n" . implode("\n",$subNav);
			$item .= "\n" . '</ul>' . "\n";
		}
		$item .= '</li>';
		$this->navItems[] = $item;
	}

	public function addHTML($html,$break = false,$return = true)
	{
		$this->html .= $html . ($break ? '<br />' : '') . ($return ? "\n" : '');
	}

	public function dump()
	{
		#print_r($this->navItems);
		$this->addContent('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">');
		$this->addContent('<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">');
		$this->addContent('<head>');
		#META
		$this->addContent(implode("\n",$this->meta));
		$this->addContent('<title>' . $this->title . '</title>');
		$this->addContent(implode("\n",$this->css));
		#FLASH SCRIPT
		if($this->showPlayer)
		{
			$embedScript = '<script type="text/javascript" src="' . DS . JS_DIR . DS . 'swfobject.js"></script>' . "\n";
			$embedScript .= '<script type="text/javascript">' . "\n";
			$embedScript .= 'var playerId = "' . $this->playerId . '";' . "\n";
			$embedScript .= 'var playerFlashvars = {};' . "\n";
			$embedScript .= 'var playerParams = {};' . "\n";
			$embedScript .= 'playerParams.allowscriptaccess = "always";' . "\n";
			$embedScript .= 'playerParams.allowFullScreen = "true";' . "\n";
			$embedScript .= 'var playerAttributes = {};' . "\n";
			$embedScript .= 'swfobject.embedSWF("' . DS . SWF_DIR . DS . 'gl_player.swf", playerId, "' . $this->playerWidth . '", "' . $this->playerHeight . '", "9.0.0", "' . DS . SWF_DIR . DS . 'expressInstall.swf", playerFlashvars, playerParams, playerAttributes);' . "\n";
			$embedScript .= '</script>';
			array_push($this->scripts,$embedScript);
			array_unshift($this->scripts,'<script type="text/javascript" src="' . DS . JS_DIR . DS . 'gl_player.js"></script>');
		}
		#print_r($this->scripts);
		$this->addContent(implode("\n",$this->scripts));

		$this->addContent('</head>');
		$this->addContent('<body>');
			$this->addContent('<div id="outerShell">');
				#HOME LINK
				$this->addContent('<div id="homeLink"><a href="/?p=1&d=1"><img src="' . DS . IMG_DIR . DS . 'gl_logo.png"/></a></div>');
				#NAVIGATION
				$this->addContent('<div id="navShell">');
					$this->addContent('<ul id="nav">');
						$this->addContent(implode("\n",$this->navItems));
					$this->addContent('</ul>');
				$this->addContent('</div>');
				#CONTENT
				$this->addContent('<div id="contentShell">');
				#FLASH PLAYER
				if($this->showPlayer)
				{
					$this->addContent('<div id="' . $this->playerId . '">');
						$this->addContent('flash not installed');
					$this->addContent('</div>');
				}
				#EXTERNAL HTML
				$this->addContent($this->html);
				#END CONTENT
				$this->addContent('</div>');
				#FOOTER
				$this->addContent('<div id="footerShell">');
					$this->addContent('<div id="footerLeft">');
						$this->addContent('&copy; ' . strftime('%Y') . ' ' . LONG_COMPANY_NAME,false);
						#$this->addContent(' / <a href="#">CLIENT LOGIN</a>');
					$this->addContent('</div>');
					$this->addContent('<div id="footerRight">');
						$this->addContent('<a href="' . ARCHITECT_URL . '">site by ' . ARCHITECT . '</a>');
					$this->addContent('</div>');
				$this->addContent('</div>');
			$this->addContent('</div>');
		$this->addContent('</body>');
		$this->addContent('</html>');
		echo $this->content;
	}
}
?>