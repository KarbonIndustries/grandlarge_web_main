<?php

/*
 * Wiredrive RSS Simple Example
 * 
 * Example file for RSS to get around same domain restrictions 
 * for Flash and Javascript.  
 *
 * This is about as simple as possible.  Get the RSS feed from Wiredrive
 * and send it on from the local server.
 *
 */

/*********************************************************************************
 * Copyright (c) 2010 IOWA, llc dba Wiredrive
 * Author Daniel Bondurant
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ********************************************************************************/

/*
 * get the the RSS feed and echo it out with XML headers
 * Change this to the RSS feed you would like to proxy on your server
 */

if(isset($_POST['feedURL']))
{
	$rss = $_POST['feedURL'];

/*
 * Make sure the RSS Url is set
 */
	if (!$rss) {
	    throw new Exception('RSS feed is not a valid URL');
	}

/*
 * read the remote RSS feed from the Wiredrive server 
 */
	$contents = file_get_contents($rss,'r');

/*
 * Make sure the RSS feed was opened.  Check the php manual
 * page on opening remote files if this fails
 *
 * @link: http://www.php.net/manual/en/features.remote-files.php
 */
	if (!$contents) {
	    throw new Exception('Unable to retrieve RSS feed');
	}

/*
 * send the XML file on to the user with headers
 */
	header('Content-Type: text/xml; charset=UTF-8');
	echo $contents;
}