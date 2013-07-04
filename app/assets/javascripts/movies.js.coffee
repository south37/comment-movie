$ ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  movieURL = "http://www.youtube.com/v/" + gon.movie_url + "?enablejsapi=1&playerapiid=ytplayer"
  swfobject.embedSWF(movieURL, "ytapiplayer", "480", "360", "8", null, null, params, atts)
  
window.timeout = (time) ->
  $.Deferred( (dfd) ->
    setTimeout dfd.resolve, time
  ).promise()

window.onYouTubePlayerReady = (playerId) ->
  window.ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange")
  makeSubmitButtonHandler()
  
window.makeSubmitButtonHandler = ->
  $('#comments-form div.submit input').click ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commentedTime
    moveNewComment()

window.moveNewComment = ->
  newMessage = $('#comment_message').val()
  moveComment $('<p>'+newMessage+'</p>').appendTo( $('#comments') )

window.onytplayerStateChange = (newState) ->
  if (newState is 1 && gon.comment_exists = true)
    if stopMovie is true
      window.stopMovie = false
      moveCommentOut $('#comments').children('p.onDisplay')
    makeComments()
  else
    window.stopMovie = true

window.makeComments = ->
  $('#comments').children('p').map ->
    comment = $(this)
    waitTime = comment.attr('commented-time') - (ytplayer.getCurrentTime() * 1000)
    if waitTime > 0
      timeout(waitTime).then(-> moveComment comment)

window.moveComment = (comment) ->
  if stopMovie is true
    return
  moveCommentIn comment
  timeout(1500).then ->
    if stopMovie is true
      return
    moveCommentOut comment

moveCommentIn = (comment) ->
  comment.css(
    'display': 'block'
    'top': randPos()
  ).addClass('animated bounceInRight').addClass('onDisplay')

window.randPos = ->
  randnum = Math.floor( Math.random() * 300 )
  randnum + 'px'

window.moveCommentOut = (comment) ->
  comment.removeClass('bounceInRight onDisplay').addClass('bounceOutLeft')