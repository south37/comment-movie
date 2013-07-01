$ ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  movieURL = "http://www.youtube.com/v/" + gon.movie_url + "?enablejsapi=1&playerapiid=ytplayer"
  swfobject.embedSWF(movieURL, "ytapiplayer", "480", "360", "8", null, null, params, atts)

window.onYouTubePlayerReady = (playerId) ->
  window.ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange")
  makeSubmitButtonHandler ytplayer
  
window.makeSubmitButtonHandler = (ytplayer) ->
  $('input[name="commit"]').click ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commentedTime
    newCommentMove()

window.newCommentMove = ->
  newMessage = $('#comment_message').val()
  commentMove $('<p>'+newMessage+'</p>').appendTo( $('#comments') )

window.onytplayerStateChange = (newState) ->
  if (newState is 1 && gon.comment_exists = true)
    window.stopMovie = false
    makeComments()
  else
    window.stopMovie = true

window.makeComments = ->
  $('#comments p').map ->
    comment = $(this)
    waitTime = comment.attr('commented-time') - (ytplayer.getCurrentTime() * 1000)
    if waitTime > 0
      setTimeout (-> commentMove comment), waitTime

window.commentMove = (comment) ->
  if stopMovie is true
    return
  commentMoveIn comment
  setTimeout (-> commentMoveOut comment), 1500

commentMoveIn = (comment) ->
  comment.css(
    'display': 'block'
    'top': randPos()
  ).addClass('animated bounceInRight')

window.randPos = ->
  randnum = Math.floor( Math.random() * 300 )
  randnum + 'px'

window.commentMoveOut = (comment) ->
  comment.removeClass('bounceInRight').addClass('bounceOutLeft')