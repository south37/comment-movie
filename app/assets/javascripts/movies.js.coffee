'use strict'

$ ->
  tag = $('<script/>').attr('src', 'http://www.youtube.com/iframe_api')
  $('#myytplayer').before(tag)
  
  window.onYouTubeIframeAPIReady = ->
    window.ytplayer = new YT.Player('myytplayer',
      height: '360'
      width: '480'
      videoId: $('#movie_url').val()
      events:
        'onReady': onYouTubePlayerReady
        'onStateChange': onytplayerStateChange
      )

  window.onYouTubePlayerReady = (event) ->
    do makeSubmitButtonHandler

  window.onytplayerStateChange = (event) ->
    if (ytplayer.getPlayerState() is 1)
      window.stopMovie = false
      moveCommentOut $('.onDisplay')
      makeComments()
    else
      window.stopMovie = true

  $('#comment_message').val('')

# utility
Util =
  timeout: (time) ->
    $.Deferred( (dfd) ->
      setTimeout dfd.resolve, time
    ).promise()
  escapeHTML: (html) ->
    do $('<div>').text(html).html

IntervalTime = 1000
YtHeight = 280
YtOffset = 80

makeSubmitButtonHandler = ->
  $('#comment-btn').click () ->
    commentedTime = Math.floor( ytplayer.getCurrentTime() * 1000 )
    $('#comment_commented_time').val commentedTime
    randPos = Math.floor( YtOffset + Math.random() * YtHeight )
    $('#comment_position').val randPos
    newMessage = Util.escapeHTML(do $('#comment_message').val)
    moveComment $('<p class="comments">'+newMessage+'</p>').attr('position', randPos).appendTo( $('#comments') )

makeComments = ->
  $('.comments').map ->
    comment = $(this)
    waitTime = comment.attr('commented-time') - (ytplayer.getCurrentTime() * 1000)
    if waitTime > 0
      Util.timeout(waitTime).then ->
        return if window.stopMovie
        moveComment comment

moveComment = (comment) ->
  moveCommentIn comment
  Util.timeout(IntervalTime).then ->
    return if window.stopMovie
    moveCommentOut comment

moveCommentIn = (comment) ->
  comment.css(
    'display': 'block'
    'top': comment.attr('position')+'px'
  ).addClass('animated bounceInRight onDisplay')

moveCommentOut = (comment) ->
  comment.removeClass('bounceInRight onDisplay').addClass('bounceOutLeft')
