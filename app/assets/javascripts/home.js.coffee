# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# create/update the Tag cloud
@populateTagCloud()
@getCardCounters()

$ -> 
	$(':input[title]').each ->
  		$this = $(this)
  		if $this.val() == ''
    		$this.val($this.attr('title'))
  		$this.focus -> 
    		if $this.val() == $this.attr('title')
      			$this.val('')
  		$this.blur ->
    		if $this.val() == ''
      			$this.val($this.attr('title'))

# provide a nice way to fade out the error messages from the Flash
$ -> 
	$('#notice span').click -> 
		$('#notice').fadeOut('slow', -> 
		)
$ -> 
	$('#errors span').click -> 
		$('#errors').fadeOut('slow', -> 
		)