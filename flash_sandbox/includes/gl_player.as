this.loaderInfo.addEventListener(Event.COMPLETE,init);
this.addEventListener(MouseEvent.MOUSE_UP,doneScrubbing);
import classes.*;
import caurina.transitions.*;
import caurina.transitions.properties.DisplayShortcuts;
DisplayShortcuts.init();

stage.scaleMode = StageScaleMode.NO_SCALE;
stage.tabChildren = false;

/* ================== */
/* = FEED CONSTANTS = */
/* ================== */
const DATA_URL:String           	= 'http://www.wdcdn.net/rss/presentation/library/client/grandlarge/id/b0cdb930ef88d72c9e5e5f007c53c420/';
const LOCAL_CREDITS_URL:String  	= '../xml/site_credits.xml';
const REMOTE_CREDITS_URL:String 	= 'http://config.karbonnyc.com/site_credits.xml?v=' + new Date().time;
const LOCAL_PROXY_URL:String		= 'http://gl.karbon.dnsalias.com/feed_proxy.php';
const REMOTE_PROXY_URL:String		= 'feed_proxy.php';
//const PROXY_URL:String    	    	= 'feed_proxy.php';
const PROXY_URL:String    	    	= Security.sandboxType == Security.REMOTE ? REMOTE_PROXY_URL : LOCAL_PROXY_URL;
const NS_1:String					= 'http://search.yahoo.com/mrss/';
const FEED_INDEX:uint				= 0;
const CREDITS_URL:String        	= Security.sandboxType == Security.REMOTE ? REMOTE_CREDITS_URL : LOCAL_CREDITS_URL;

/* ========== */
/* = EVENTS = */
/* ========== */
const THUMBS_LOADED:String			= 'thumbsLoaded';
const THUMB_CLICKED:String			= 'thumbClicked';
const SLIDE_COMPLETE:String			= 'slideComplete';
const POSTERS_LOADED:String			= 'postersLoaded';
const POSTER_CLICKED:String			= 'posterClicked';
const TOGGLE_FS:String				= 'toggleFullscreen';
const SCRUBBING:String				= 'scrubbing';

/* =================== */
/* = FEED PROPERTIES = */
/* =================== */
var mediaNS:Namespace;
var dataLoader:URLLoader;
var feedReq:URLRequest;
var feedVars:URLVariables;
var data:XML;
var xItems:XMLList;

/* ============== */
/* = PROPERTIES = */
/* ============== */
var framesReady:Boolean;
var thumbsReady:Boolean;


/* ========== */
/* = COLORS = */
/* ========== */
const GL_BLUE:uint					= 0x65A7C0;
const BLACK:uint					= 0x000000;
const WHITE:uint					= 0xFFFFFF;

/* ================== */
/* = CUSTOM CLASSES = */
/* ================== */
var frameSlider:GLFrameSlider;
var thumbSlider:GLThumbnailSlider;
var videoPlayer:GLVideoPlayer;
var info:GLInfoDisplay;

Karbonizer.loadCredits(CREDITS_URL,2,this);

/* ============= */
/* = FUNCTIONS = */
/* ============= */

function init(e:Event):void
{
	dataLoader = new URLLoader();
	dataLoader.addEventListener(Event.COMPLETE,dataLoaded);
	feedReq = new URLRequest(PROXY_URL);
	feedReq.method = URLRequestMethod.POST;
	feedVars = new URLVariables();
	feedReq.data = feedVars;
	ExternalInterface.addCallback("loadPlaylist",loadPlaylist);
	ExternalInterface.call("initShowreel");
	//loadPlaylist(DATA_URL);
}

function dataLoaded(e:Event):void
{
	data = XML(e.target.data);
	mediaNS = new Namespace(NS_1);
	xItems = data.channel.item;
	var credit:XMLList = xItems[FEED_INDEX].mediaNS::credit;
	info = new GLInfoDisplay(credit[0],credit[1],credit[2]);
	info.x = -3;
	info.y = 672;
	addChild(info);
	var imgs:Object = new Object();
	imgs.posters = new Array();
	imgs.thumbs = new Array();
	for each(var x:XML in xItems)
	{
		imgs.posters.push(x.mediaNS::thumbnail[0].@url);
		imgs.thumbs.push(x.mediaNS::thumbnail[1].@url);
	}
	frameSlider = new GLFrameSlider();
	frameSlider.addEventListener(POSTERS_LOADED,postersLoaded);
	frameSlider.addEventListener(POSTER_CLICKED,posterClicked);
	frameSlider.x = frameSlider.y = 0;
	addChild(frameSlider);
	frameSlider.load(imgs.posters)

	thumbSlider = new GLThumbnailSlider();
	thumbSlider.addEventListener(THUMBS_LOADED,thumbsLoaded);
	thumbSlider.addEventListener(THUMB_CLICKED,thumbClicked);
	thumbSlider.addEventListener(SLIDE_COMPLETE,slideTransition);
	thumbSlider.y = 540;
	addChild(thumbSlider);
	thumbSlider.load(imgs.thumbs);
	
	videoPlayer = new GLVideoPlayer();
	videoPlayer.addEventListener(Karbonizer.VIDEO_EVENT.COMPLETE,videoComplete);
	videoPlayer.addEventListener(TOGGLE_FS,toggleFullscreen);
	videoPlayer.visible = false;
	addChild(videoPlayer);
	stage.addEventListener(KeyboardEvent.KEY_UP,keyPressed);
}

function videoComplete(e:Event):void
{
	if(e.target.id == xItems.length() - 1)
	{
		frameSlider.reset();
		thumbSlider.resetSlider();
		thumbSlider.initSlideshow();
		e.target.hide();
	}else
	{
		var newId:uint = e.target.id + 1;
		e.target.play(xItems[newId].mediaNS::content.@url,newId);
		!thumbSlider.sameFrame ? updateInfo(newId,false) : null;
	}
}

function checkSlideshow():void
{
	if(framesReady && thumbsReady)
	{
		thumbSlider.initSlideshow();	
	}
}

function postersLoaded(e:Event):void
{
	framesReady = true;
	checkSlideshow();
}

function posterClicked(e:Event):void
{
	thumbSlider.reset(frameSlider.clickedFrameId);
}

function thumbsLoaded(e:Event):void
{
	thumbsReady = true;
	checkSlideshow();
}

function thumbClicked(e:Event):void
{
	var id:uint = thumbSlider.currentThumbId;
	var video:String = xItems[id].mediaNS::content.@url;
	videoPlayer.play(video,id);
	!thumbSlider.sameFrame ? updateInfo(id,false) : null;
}

function slideTransition(e:Event):void
{
	var id:uint = GLThumbnailSlider(e.target).currentThumbId;
	updateInfo(id);
}

function updateInfo(id:uint,showFrame:Boolean = true):void
{
	var txt1:String = xItems[id].mediaNS::credit[0];
	var txt2:String = xItems[id].mediaNS::credit[1];
	var txt3:String = xItems[id].mediaNS::credit[2];
/*
	var txt1:String = getFeedValue(xItems[id].mediaNS::credit[0]);
	var txt2:String = getFeedValue(xItems[id].mediaNS::credit[1]);
	var txt3:String = getFeedValue(xItems[id].mediaNS::credit[2]);
*/
	//var txt1:String = xItems[id].mediaNS::credit.(@role.indexOf('dir') == 0);
	//var txt2:String = xItems[id].mediaNS::credit.(@role.indexOf('cli') == 0);
	//var txt3:String = xItems[id].mediaNS::credit.(@role.indexOf('age') == 0);
	info.updateDisplay(txt1,txt2,txt3);
	showFrame ? frameSlider.show(id) : null;
}

function loadPlaylist(url:String):void
{
	feedVars.feedURL = url;
	//feedReq.data = feedVars;
	dataLoader.load(feedReq);
}

function getFeedValue(str:String):String
{
    return new XMLDocument(str).firstChild.nodeValue;
}

function toggleFullscreen(e:Event = null):void
{
	stage.displayState == StageDisplayState.NORMAL ? fullscreen() : exitFullscreen();
	Karbonizer.echo(stage.displayState);
}

function fullscreen():void
{
	stage.displayState = StageDisplayState.FULL_SCREEN;
	thumbSlider.dim = true;
	//Karbonizer.centerTo(vm,stage,true,false);
}

function exitFullscreen():void
{
	stage.displayState = StageDisplayState.NORMAL;
	thumbSlider.dim = false;
}

function doneScrubbing(e:Event):void
{
	videoPlayer.isScrubbing ? videoPlayer.doneScrubbing() : null;
}

function keyPressed(e:KeyboardEvent = null):void
{
	e.keyCode == Karbonizer.KEYS.SPACEBAR ? videoPlayer.togglePlayPause() : null;
}

