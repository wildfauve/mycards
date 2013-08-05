@populateTagCloud = () ->
	$("#tag-cloud").empty()
	$.ajax
		url: '/tags/tag_cloud.json'
		success: (data) ->
			$("#tag-cloud"	).jQCloud(data, {
				height: 450, 
				width: 380
				})

#TODO:  This should really return the count and NOT do the view
@getCardCounters = ()	->
	$.ajax({ 
		url: '/cards/counters.json',
		data: 'prop=count',
		success: (data) -> 
			$('#cd-count-sum .cd-number').text(data.ct)
		})