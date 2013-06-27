$ ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  swfobject.embedSWF("http://www.youtube.com/v/pNlLv8rgRSo?enablejsapi=1&playerapiid=ytplayer", "ytapiplayer", "425", "356", "8", null, null, params, atts)

window.onYouTubePlayerReady = (playerId) ->
  ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange")
  makeSubmitButtonHandler ytplayer
  
window.makeSubmitButtonHandler = (ytplayer) ->
  $('input', $('.submit')).click ->
    commented_time = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commented_time

window.onytplayerStateChange = (newState) ->
  if newState is 1
    $('#comments p').map ->
      comment = $(this)
      commentedTime = comment.attr('commented-time')
      setTimeout ->
        commentMove comment
      , commentedTime

window.commentMove = (comment) ->
  randnum = Math.floor( Math.random() * 300 )
  topPos = randnum + 'px'
  comment.css(
    'display': 'block'
    'top': topPos
  ).textillate(
    loop: true
    minDisplayTime: 500
    autoStart: true
  )
  setTimeout ->
    comment.css({'display':'none'})
  , 5500