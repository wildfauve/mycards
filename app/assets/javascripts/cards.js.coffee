# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('.date-picker').datepicker {
		dateFormat: "dd-mm-yy"
	}
	$('#card_card_tags').tokenInput('/tags/query.json', { 
		crossDomain: false,
		prePopulate: $('#cards_card_tags').data("pre"),
		theme: "mac"
	 })
	$('#card_card_custs').tokenInput('/customers/query.json', { 
		crossDomain: false,
		prePopulate: $('#cards_card_custs').data("pre"),
		theme: "mac"
	 })