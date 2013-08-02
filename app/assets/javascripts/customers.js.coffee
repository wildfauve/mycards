# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@filterCustomer = () ->
	$("#customer_name").keyup (event) ->
		q = $("#customer_name").val
		alert(q)
@filterCustomer()