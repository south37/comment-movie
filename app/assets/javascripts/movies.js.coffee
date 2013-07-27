jQuery ->
  tag = jQuery('<script/>').attr('src', 'http://www.youtube.com/iframe_api')
  jQuery('#myytplayer').before(tag)
  
  window.onYouTubeIframeAPIReady = ->
    window.ytplayer = new YT.Player('myytplayer',
      height: '360'
      width: '480'
      videoId: gon.movie_url
      events:
        'onReady': onYouTubePlayerReady
        'onStateChange': onytplayerStateChange
      )

  window.onYouTubePlayerReady = (event) ->
    makeSubmitButtonHandler()

  window.onytplayerStateChange = (event) ->
    if (ytplayer.getPlayerState() is 1 && gon.comment_exists = true)
      window.stopMovie = false
      moveCommentOut jQuery('#comments').children('p.onDisplay')
      makeComments()
    else
      window.stopMovie = true

timeout = (time) ->
  jQuery.Deferred( (dfd) ->
    setTimeout dfd.resolve, time
  ).promise()
  
makeSubmitButtonHandler = ->
  jQuery('#comments-form div.submit input').click ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    jQuery('#comment_commented_time').val commentedTime
    moveNewComment()

moveNewComment = ->
  newMessage = jQuery('#comment_message').val()
  moveComment jQuery('<p>'+newMessage+'</p>').appendTo( jQuery('#comments') )

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
