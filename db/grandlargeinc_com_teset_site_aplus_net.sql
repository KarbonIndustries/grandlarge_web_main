-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 14, 2011 at 04:21 PM
-- Server version: 5.1.37
-- PHP Version: 5.2.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `grandlargeinc_com_teset_site_aplus_net`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE `about` (
  `id` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `image` varchar(255) NOT NULL DEFAULT '',
  `col1` text NOT NULL,
  `col2` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `about`
--

INSERT INTO `about` VALUES(1, 'gl_about.jpg', 'Grand Large is an international production company founded by Steve Horton in Paris, France June 2001.\n\nTogether with a diverse group of directors and designers, Grand Large is known for its ability to deliver effective commercials, new media content and music videos.', 'Clients include Jaguar, Ray Ban, Hilfiger, Cartier, L''oreal, Coca Cola, Avon, Marionnaud, Mars, COI, Schwinn, Verizon, Nivea, Moby, Sundance Channel, The New York Times&hellip;\n\nOffices in New York and Paris give us the flexibility to produce and foster creative talent on the international stage.');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `officeCategoryID` smallint(3) unsigned NOT NULL DEFAULT '0',
  `officeLocale` varchar(40) NOT NULL DEFAULT '',
  `companyName` varchar(40) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `city` varchar(40) NOT NULL DEFAULT '',
  `stateID` tinyint(2) unsigned NOT NULL DEFAULT '51',
  `country` varchar(40) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `contact1FirstName` varchar(40) NOT NULL DEFAULT '',
  `contact1LastName` varchar(40) NOT NULL DEFAULT '',
  `contact2FirstName` varchar(40) NOT NULL DEFAULT '',
  `contact2LastName` varchar(40) NOT NULL DEFAULT '',
  `contact3FirstName` varchar(40) NOT NULL DEFAULT '',
  `contact3LastName` varchar(40) NOT NULL DEFAULT '',
  `phone` varchar(16) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `websiteURL` varchar(2083) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `stateID` (`stateID`),
  KEY `country` (`country`),
  KEY `companyName` (`companyName`),
  KEY `officeLocale` (`officeLocale`),
  KEY `officeCategoryID` (`officeCategoryID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` VALUES(1, 1, 'New York', 'Grand Large Inc.', '54 Mercer Street', '', '', 'New York', 32, 'USA', '10013', 'Steven', 'Horton', '', '', '', '', '2129888390', 'steven@grandlargeinc.com', 'www.grandlargeinc.com');
INSERT INTO `contacts` VALUES(2, 1, 'Paris', 'Grand Large Inc.', '22 Rue de Navarin', '', '', 'Paris', 51, 'France', '75009', 'Steven', 'Horton', '', '', '', '', '33143060330', 'info@grandlargeinc.com', 'www.grandlargeinc.com');
INSERT INTO `contacts` VALUES(3, 2, 'East Coast', 'FM Artist Management', '30 Irving Place', '6th Floor', '', 'New York', 32, 'USA', '10013', 'Carl', 'Forsberg', 'Marianne', 'McCarley', '', '', '2125812200', 'carl@fmartist.com', 'www.forsbergmccarley.com');
INSERT INTO `contacts` VALUES(4, 2, 'Midwest', 'Hilly Reps', '680 North Lake Shore Drive', 'Suite 320', '', 'Chicago', 13, 'USA', '60611', 'Hillary', 'Herbst', 'Laurel', 'Dobose', '', '', '3129441100', 'hillary@hillyreps.com', 'www.hillyreps.com');
INSERT INTO `contacts` VALUES(5, 2, 'West Coast', 'Two Tricky Pony, Inc.', '21816 Grovepark Drive', '', '', 'Santa Clarita', 5, 'USA', '91350', 'Jonathan', 'Miller', '', '', '', '', '2123008962', 'jmiller@2trickypony.com', 'www.2trickpony.com');

-- --------------------------------------------------------

--
-- Table structure for table `directors`
--

CREATE TABLE `directors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `bio` text,
  `websiteURL` varchar(2083) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `active` (`active`),
  KEY `firstName` (`firstName`),
  KEY `lastName` (`lastName`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `directors`
--

INSERT INTO `directors` VALUES(1, 1, 'Tracey', 'Rowe', 'Tracey''s work is known for compelling rich images and stylish details. She thrives on bringing the emotional content out of each visual while at the same time enhancing the concept of the film.', 'http://www.traceyrowe.com', '');
INSERT INTO `directors` VALUES(2, 1, 'Gaysorn', 'Thavat', 'Gaysorn''s work has a distinctive and smart humor infused with a stylish and fresh approach.  From drama to comedy, she is recognized for her strong visuals, inspiring performances and passion for storytelling.\n\nHer commercial titled "Dying Old" for the Breast Cancer Research Trust in New Zealand was awarded a Gold Lion at the Cannes International Advertising Festival 2009.', '', '');
INSERT INTO `directors` VALUES(3, 1, 'Jean-Pierre', 'Jeunet', 'Jean-Pierre Jeunet is the writer/director behind the wonderfully imaginative films <em>Am&eacute;lie, The City Of Lost Children, and Delicatessen</em>. He began his career in France shooting television commercials, music videos and short films.', 'http://www.jpjeunet-siteofficiel.com', '');
INSERT INTO `directors` VALUES(4, 1, 'Francesco', 'Carrozzini', 'New York based Italian, Francesco Carrozzini is an internationally recognized photographer and noted filmmaker.  He has amassed an extensive print portfolio, as well as commercials for Est&eacute;e Lauder, Tommy Hilfiger, Ray-Ban and The New York Times.', 'http://www.francescocarrozzini.com', '');
INSERT INTO `directors` VALUES(5, 1, 'Fred', 'Garson', 'Fred Garson is a commercial and feature film director who has a very strong eye for what is modern and fresh.  He is also heavily involved in the music industry and brings an enormous energy and style to all his films.', '', '');
INSERT INTO `directors` VALUES(6, 1, 'Tom', 'Kan', 'Tom Kan is a French born and raised Japanese national based in Paris. He has directed commercials as well as music videos for iconic French artists Daft Punk, Ophelie Winter and AIR. Tom is also known for his design work, having done logos, album covers and movie titles.', 'http://www.tomkandesign.com', '');
INSERT INTO `directors` VALUES(7, 1, 'Bettina', 'Rheims', 'Bettina is renowned for her erotic black and white portraits of women as well as for working with famous actresses such as Catherine Deneuve, Charlotte Rampling, Lauren Bacall, Glenn Close, Daryl Hannah and Sharon Stone. Her film style is intrinsically modern, sensual, intricate and relevant.', '', '');
INSERT INTO `directors` VALUES(8, 1, 'Serge', 'Guerand', 'Serge Guerand is a French based photographer as well as a commercial and music video director.  He has a warm sensibility and an amazing ability to connect with his actors to bring out strong performances, especially with children.', 'http://www.guerand.com', '');
INSERT INTO `directors` VALUES(9, 1, 'Liz', 'Hinlein', 'Liz Hinlein is an award-winning director, having directed national television spots for Clairol, Revlon, Almay, Maybelline, Wella and Nivea, among others.', '', '');
INSERT INTO `directors` VALUES(10, 1, 'Mark', 'Tiedemann', 'New York based Mark Tiedemann is an accomplished comedic director for television and the Internet.  He has directed commercials for Staples, Chevy, McDonalds, Sony Playstation, Kia, Dish TV, Campbell''s, Lysol, Schick, Motorola, Ikea, ATT, Baby Ruth and Verizon.', '', '');
INSERT INTO `directors` VALUES(11, 1, 'Marc', 'Caro', 'Marc Caro, is a French filmmaker and illustrator, best known for his co-directing projects, <em>Delicatessen</em> and <em>City of Lost Children</em>.  He is noted for his creative character design, which is present in his latest sci-fi inspired feature film <em>Dante 01</em>.', '', '');
INSERT INTO `directors` VALUES(12, 1, 'Tran anh', 'Hung', 'French-Vietnamese director, Tran Anh Hung has a strong eye for color, texture and beauty.  His Oscar-nominated debut (for Best foreign film) was with <em>The Scent of Green Papaya</em>, which also won two top prizes at the prestigious 1993 Cannes Film Festival.', '', '');
INSERT INTO `directors` VALUES(13, 1, 'Showreel', '', '', '', 'grand large showreel');
INSERT INTO `directors` VALUES(15, 1, 'Yoann', 'Lemoine', '', '', '');
INSERT INTO `directors` VALUES(16, 1, 'Ronald', 'Wohlman', '', '', '');
INSERT INTO `directors` VALUES(17, 1, 'Shizue', '', '', '', '');
INSERT INTO `directors` VALUES(18, 1, 'Leif-Husted', 'Jensen', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `fileRecords`
--

CREATE TABLE `fileRecords` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fileID` int(11) unsigned NOT NULL,
  `forUserID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fileID` (`fileID`),
  KEY `forUserID` (`forUserID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `fileRecords`
--


-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fileTypeID` tinyint(2) unsigned NOT NULL,
  `name` varchar(60) NOT NULL,
  `file` varchar(40) NOT NULL,
  `addedByUserID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fileTypeID_2` (`fileTypeID`),
  KEY `fileTypeID` (`fileTypeID`),
  KEY `addedByUserID` (`addedByUserID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `files`
--


-- --------------------------------------------------------

--
-- Table structure for table `fileTypes`
--

CREATE TABLE `fileTypes` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `fileTypes`
--


-- --------------------------------------------------------

--
-- Table structure for table `mediaCategories`
--

CREATE TABLE `mediaCategories` (
  `id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `navId` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `navId` (`navId`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `mediaCategories`
--

INSERT INTO `mediaCategories` VALUES(1, 1);
INSERT INTO `mediaCategories` VALUES(2, 2);
INSERT INTO `mediaCategories` VALUES(3, 3);
INSERT INTO `mediaCategories` VALUES(4, 4);
INSERT INTO `mediaCategories` VALUES(5, 5);
INSERT INTO `mediaCategories` VALUES(6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `mediaFeeds`
--

CREATE TABLE `mediaFeeds` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mediaCategoryID` smallint(3) unsigned NOT NULL,
  `categoryPosition` tinyint(2) unsigned NOT NULL,
  `directorID` int(11) unsigned NOT NULL DEFAULT '0',
  `feedURL` varchar(2083) NOT NULL,
  `timeAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `mediaCategoryID` (`mediaCategoryID`),
  KEY `directorID` (`directorID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `mediaFeeds`
--

INSERT INTO `mediaFeeds` VALUES(1, 1, 1, 13, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/8fecac0a24cf58794b1954d338b641aa/', '2011-01-03 23:49:03', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(2, 2, 1, 1, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/760dd15520de190a03949d5cd60cd065/', '2011-01-03 23:51:09', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(3, 2, 2, 2, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/af079faf9d205592723c7fa09cb6a101/', '2011-01-03 23:51:52', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(4, 2, 3, 3, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/e563367bd2ccfb3d63108e728730e69b/', '2011-01-03 23:52:13', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(5, 2, 4, 4, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/5c2bd5e8fe904f277219fc54b3f5365b/', '2011-01-03 23:52:37', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(6, 2, 5, 5, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/2023b53d7fe5cbb0f5cab5827a6f105e/', '2011-01-03 23:52:46', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(7, 2, 6, 6, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/f0c36fd382d5895cff4c05359929a66e/', '2011-01-03 23:52:58', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(8, 3, 1, 7, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/f51b9282a8cb64eec0b519b3ea47080d/', '2011-01-03 23:53:36', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(9, 3, 2, 8, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/16eb32b9ffb3f055cc49c20257b0e892/', '2011-01-03 23:53:44', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(10, 4, 1, 9, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/8d9782a078190646548445a4db4604c9/', '2011-01-03 23:54:49', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(11, 4, 2, 10, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/00eb5062d6d6b807421ace679ad0af31/', '2011-01-03 23:54:57', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(12, 5, 1, 3, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/e563367bd2ccfb3d63108e728730e69b/', '2011-01-03 23:55:25', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(13, 5, 2, 11, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/2838ddc0a0a766181709e98d178b0267/', '2011-01-03 23:55:30', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(14, 5, 3, 12, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/e99ac277129794a1147304223b99d247/', '2011-01-03 23:55:37', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(15, 6, 1, 15, 'http://www.wdcdn.net/rss/presentation/library/client/glx/id/24bb3af337e74439e9a085014a745b77/', '2011-01-10 22:08:55', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(21, 3, 3, 17, 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/764f64738132ac5166b772ffe733d4b9/', '2011-02-05 15:55:15', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(20, 6, 4, 16, 'http://www.wdcdn.net/rss/presentation/library/client/glx/id/319800429084791d370a9733e4861d9a/', '2011-02-05 15:51:16', '0000-00-00 00:00:00');
INSERT INTO `mediaFeeds` VALUES(22, 6, 3, 18, 'http://www.wdcdn.net/rss/presentation/library/client/glx/id/a9e971d1fd2f5d6ee38575437e8024a4/', '2011-03-06 16:56:28', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `navigation`
--

CREATE TABLE `navigation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `navigation`
--

INSERT INTO `navigation` VALUES(1, 'Showreel');
INSERT INTO `navigation` VALUES(2, 'Commercials');
INSERT INTO `navigation` VALUES(3, 'Beauty');
INSERT INTO `navigation` VALUES(4, 'International');
INSERT INTO `navigation` VALUES(5, 'Feature Film');
INSERT INTO `navigation` VALUES(6, 'GL-X');
INSERT INTO `navigation` VALUES(7, 'Notable');
INSERT INTO `navigation` VALUES(8, 'About');
INSERT INTO `navigation` VALUES(9, 'Contact');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL,
  `image` varchar(32) NOT NULL,
  `desc` text NOT NULL,
  `url` varchar(2083) NOT NULL,
  `timeAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `addedByUserID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timeAdded` (`timeAdded`),
  KEY `addedByUserID` (`addedByUserID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `news`
--

INSERT INTO `news` VALUES(1, 'BUF', 'buf.jpg', 'BUF', 'http://www.buf.com', '2011-01-10 13:01:09', 1);
INSERT INTO `news` VALUES(2, 'Walkabout Films', 'walkabout.jpg', 'Walkabout Films', 'http://www.walkaboutfilms.comau.com', '2011-01-10 12:02:15', 1);
INSERT INTO `news` VALUES(5, 'Mac Guff', 'mac_guff.jpg', 'Mac Guff', 'http://www.macguff.com', '2011-01-10 11:02:44', 1);
INSERT INTO `news` VALUES(4, 'Animal Logic', 'animal_logic.jpg', 'Animal Logic', 'http://www.animallogic.com', '2011-01-10 10:03:41', 1);
INSERT INTO `news` VALUES(3, 'Robbers Dog', 'robbers_dog.jpg', 'Robbers Dog', 'http://www.robbersdog.co.nz', '2011-01-10 09:03:44', 1);
INSERT INTO `news` VALUES(7, 'Tom Kan Design', 'tom_kan.jpg', 'Tom Kan Design', 'http://www.tomkandesign.com', '2011-01-10 08:05:00', 1);
INSERT INTO `news` VALUES(6, 'Francesco Carrozzini', 'francesco_carrozzini.jpg', 'Francesco Carrozzini', 'http://www.francescocarrozzini.com', '2011-01-10 07:06:03', 1);
INSERT INTO `news` VALUES(8, 'Rockwood Music Hall', 'rockwood_music_hall.jpg', 'Rockwood Music Hall', 'http://www.rockwoodmusichall.com', '2011-01-10 06:50:32', 1);
INSERT INTO `news` VALUES(9, 'Cosmic', 'cosmic.jpg', 'Cosmic', 'http://www.cosmicparis.com/#/bruno_delbonnel', '2011-01-10 06:40:04', 1);
INSERT INTO `news` VALUES(10, 'Piffeteau', 'piffeteau.jpg', 'Piffeteau', 'http://www.piffeteau.com', '2011-01-10 06:30:33', 1);
INSERT INTO `news` VALUES(11, 'Kinou', 'kinou.jpg', 'Kinou', 'http://www.kinou.fr', '2011-01-10 06:25:53', 1);
INSERT INTO `news` VALUES(12, 'Nicolas Loir', 'nicolas_loir.jpg', 'Nicolas Loir', 'http://www.nicolasloir.com', '2011-01-10 06:20:21', 1);
INSERT INTO `news` VALUES(13, 'World Locations', 'world_locations.jpg', 'World Locations', 'http://www.worldlocations.com', '2011-01-10 06:15:43', 1);
INSERT INTO `news` VALUES(14, 'G2 Works', 'g2_works.jpg', 'G2 Works', 'http://www.g2works.com', '2011-01-10 06:10:44', 1);
INSERT INTO `news` VALUES(15, 'Franck Tymezuk', 'francky_tymezuk.jpg', 'Franck Tymezuk', 'http://www.francktymezuk.com', '2011-01-10 06:06:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `officeCategories`
--

CREATE TABLE `officeCategories` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `officeCategories`
--

INSERT INTO `officeCategories` VALUES(1, 'Offices');
INSERT INTO `officeCategories` VALUES(2, 'Sales');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `abbreviation` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `states`
--

INSERT INTO `states` VALUES(1, 'AL');
INSERT INTO `states` VALUES(2, 'AK');
INSERT INTO `states` VALUES(3, 'AZ');
INSERT INTO `states` VALUES(4, 'AR');
INSERT INTO `states` VALUES(5, 'CA');
INSERT INTO `states` VALUES(6, 'CO');
INSERT INTO `states` VALUES(7, 'CT');
INSERT INTO `states` VALUES(8, 'DE');
INSERT INTO `states` VALUES(9, 'FL');
INSERT INTO `states` VALUES(10, 'GA');
INSERT INTO `states` VALUES(11, 'HI');
INSERT INTO `states` VALUES(12, 'ID');
INSERT INTO `states` VALUES(13, 'IL');
INSERT INTO `states` VALUES(14, 'IN');
INSERT INTO `states` VALUES(15, 'IA');
INSERT INTO `states` VALUES(16, 'KS');
INSERT INTO `states` VALUES(17, 'KY');
INSERT INTO `states` VALUES(18, 'LA');
INSERT INTO `states` VALUES(19, 'ME');
INSERT INTO `states` VALUES(20, 'MD');
INSERT INTO `states` VALUES(21, 'MA');
INSERT INTO `states` VALUES(22, 'MI');
INSERT INTO `states` VALUES(23, 'MN');
INSERT INTO `states` VALUES(24, 'MS');
INSERT INTO `states` VALUES(25, 'MO');
INSERT INTO `states` VALUES(26, 'MT');
INSERT INTO `states` VALUES(27, 'NE');
INSERT INTO `states` VALUES(28, 'NV');
INSERT INTO `states` VALUES(29, 'NH');
INSERT INTO `states` VALUES(30, 'NJ');
INSERT INTO `states` VALUES(31, 'NM');
INSERT INTO `states` VALUES(32, 'NY');
INSERT INTO `states` VALUES(33, 'NC');
INSERT INTO `states` VALUES(34, 'ND');
INSERT INTO `states` VALUES(35, 'OH');
INSERT INTO `states` VALUES(36, 'OK');
INSERT INTO `states` VALUES(37, 'OR');
INSERT INTO `states` VALUES(38, 'PA');
INSERT INTO `states` VALUES(39, 'RI');
INSERT INTO `states` VALUES(40, 'SC');
INSERT INTO `states` VALUES(41, 'SD');
INSERT INTO `states` VALUES(42, 'TN');
INSERT INTO `states` VALUES(43, 'TX');
INSERT INTO `states` VALUES(44, 'UT');
INSERT INTO `states` VALUES(45, 'VT');
INSERT INTO `states` VALUES(46, 'VA');
INSERT INTO `states` VALUES(47, 'WA');
INSERT INTO `states` VALUES(48, 'WV');
INSERT INTO `states` VALUES(49, 'WI');
INSERT INTO `states` VALUES(50, 'WY');
INSERT INTO `states` VALUES(51, '');
INSERT INTO `states` VALUES(52, 'DC');
INSERT INTO `states` VALUES(53, 'PR');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userTypeID` tinyint(2) unsigned NOT NULL,
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `email` varchar(255) NOT NULL,
  `key` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `userTypeID` (`userTypeID`),
  KEY `lastName` (`lastName`),
  KEY `firstName` (`firstName`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` VALUES(1, 3, 'Shammel', 'Lee', 'sidekick2rida@gmail.com', 'letmein');

-- --------------------------------------------------------

--
-- Table structure for table `userTypes`
--

CREATE TABLE `userTypes` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `accessLevel` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accessLevel` (`accessLevel`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `userTypes`
--

INSERT INTO `userTypes` VALUES(1, 'client', 0);
INSERT INTO `userTypes` VALUES(2, 'admin', 0);
INSERT INTO `userTypes` VALUES(3, 'architect', 0);
