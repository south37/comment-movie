'use strict'

$ ->
  tag = $('<script/>').attr('src', 'http://www.youtube.com/iframe_api')
  $('#myytplayer').before(tag)
  
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
      moveCommentOut $('#comments').children('p.onDisplay')
      makeComments()
    else
      window.stopMovie = true

  $('#comment_message').val('')

timeout = (time) ->
  $.Deferred( (dfd) ->
    setTimeout dfd.resolve, time
  ).promise()
  
makeSubmitButtonHandler = ->
  $('#comment-btn').click () ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commentedTime
    newMessage = $('#comment_message').val()
    moveComment $('<p class="comments">'+newMessage+'</p>').appendTo( $('#comments') )

makeComments = ->
  $('.comments').map ->
    comment = $(this)
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
  randnum = Math.floor( Math.random() * 290 ) + 80
  randnum + 'px'

moveCommentOut = (comment) ->
  comment.removeClass('bounceInRight onDisplay').addClass('bounceOutLeft')
