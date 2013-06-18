params = { allowScriptAccess: "always" };
atts = { id: "myytplayer" };

$ ->
  swfobject.embedSWF("http://www.youtube.com/v/pNlLv8rgRSo?enablejsapi=1&playerapiid=ytplayer", "ytapiplayer", "425", "356", "8", null, null, params, atts);