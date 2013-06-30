$ ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  movieURL = "http://www.youtube.com/v/" + gon.movie_url + "?enablejsapi=1&playerapiid=ytplayer"
  swfobject.embedSWF(movieURL, "ytapiplayer", "480", "360", "8", null, null, params, atts)

window.onYouTubePlayerReady = (playerId) ->
  ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange")
  makeSubmitButtonHandler ytplayer
  
window.makeSubmitButtonHandler = (ytplayer) ->
  $('input[name="commit"]').click ->
    commented_time = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commented_time
    newMessage = $('#comment_message').val()
    commentMove $('<p>'+newMessage+'</p>').appendTo( $('#comments') )

window.onytplayerStateChange = (newState) ->
  if newState is 1
    if gon.comment_exists != true
      return
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
    'visibility': 'visible'
  ).addClass('animated bounceInRight')
  setTimeout ->
    comment.removeClass('bounceInRight').addClass('bounceOutLeft')
  , 2000