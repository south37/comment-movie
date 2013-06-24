$ ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  swfobject.embedSWF("http://www.youtube.com/v/pNlLv8rgRSo?enablejsapi=1&playerapiid=ytplayer", "ytapiplayer", "425", "356", "8", null, null, params, atts)
  $('#4').css({'display':'block'}).textillate()
  
window.onYouTubePlayerReady = (playerId) ->
  window.ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStageChange", "onytplayerStateChange")

window.alertPassedTime = ->
  alert ytplayer.getCurrentTime()