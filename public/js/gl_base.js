function track()
{
	var _gaq = _gaq || [];
	_gaq.push(["_setAccount", "UA-21646353-1"]);
	_gaq.push(["_trackPageview"]);
	(function()
	{
		var ga = document.createElement("script");
		ga.type = "text/javascript";
		ga.async = true;
		ga.src = ("https:" == document.location.protocol ? "https://ssl" : "http://www") + ".google-analytics.com/ga.js";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(ga, s);
	})();
}

function checkAgent(baseURL)
{
	var ua = navigator.userAgent;
	if(ua.indexOf("iPh") >= 0 || ua.indexOf("iPo") >= 0)
	{
		window.location.replace(baseURL + "mobile/");
	}
}

function testMobile(redirectURL)
{
	if(navigator.userAgent.indexOf("iPh") < 0 && navigator.userAgent.indexOf("iPo") < 0)
	{
		window.location.replace(redirectURL);
	}
}