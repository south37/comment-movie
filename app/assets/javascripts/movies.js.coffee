jQuery ->
  params = { allowScriptAccess: "always" }
  atts = { id: "myytplayer" }
  movieURL = "http://www.youtube.com/v/" + gon.movie_url + "?enablejsapi=1&playerapiid=ytplayer"
  swfobject.embedSWF(movieURL, "ytapiplayer", "480", "360", "8", null, null, params, atts)
  
timeout = (time) ->
  jQuery.Deferred( (dfd) ->
    setTimeout dfd.resolve, time
  ).promise()

window.onYouTubePlayerReady = (playerId) ->
  window.ytplayer = document.getElementById("myytplayer")
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange")
  makeSubmitButtonHandler()
  
makeSubmitButtonHandler = ->
  jQuery('#comments-form div.submit input').click ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    jQuery('#comment_commented_time').val commentedTime
    moveNewComment()

moveNewComment = ->
  newMessage = jQuery('#comment_message').val()
  moveComment jQuery('<p>'+newMessage+'</p>').appendTo( jQuery('#comments') )

window.onytplayerStateChange = (newState) ->
  if (newState is 1 && gon.comment_exists = true)
    if window.stopMovie is true
      window.stopMovie = false
      moveCommentOut jQuery('#comments').children('p.onDisplay')
    makeComments()
  else
    window.stopMovie = true

makeComments = ->
  jQuery('#comments').children('p').map ->
    comment = jQuery(this)
    waitTime = comment.attr('commented-time') - (ytplayer.getCurrentTime() * 1000)
    if waitTime > 0
      timeout(waitTime).then ->
        if stopMovie is true
          return
        moveComment comment

moveComment = (comment) ->
  moveCommentIn comment
  timeout(1500).then ->
    if stopMovie is true
      return
    moveCommentOut comment

moveCommentIn = (comment) ->
  comment.css(
    'display': 'block'
    'top': randPos()
  ).addClass('animated bounceInRight onDisplay')

randPos = ->
  randnum = Math.floor( Math.random() * 300 )
  randnum + 'px'

moveCommentOut = (comment) ->
  comment.removeClass('bounceInRight onDisplay').addClass('bounceOutLeft')
