function loadPlaylist(url)
{
	var player = document[playerId] || window[playerId];
	player.loadPlaylist(url);
}

function initShowreel()
{
	loadPlaylist(feed);
}

