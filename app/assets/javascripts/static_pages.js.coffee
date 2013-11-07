# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
jQuery ->
  # Animation for main sidebar
  $(".navbar-nav > li").on 'click', (e) ->
    $this = $(this)
    # Remove current active class
    $this.parent().children('.active').removeClass('active') if  $this.parent().children('.active')?

    # Add current active class if it does not exist
    $this.addClass('active') if not $this.hasClass('active')
