<% head_date_data = @card.date_made.strftime('%s')  %> 

# clear errors just in case
$('#new-status').empty()

# Create a header to place the card item under
header = $(".cd-date-hdr[data-date='<%= head_date_data%>']")
if header.length == 0
	<% card = @card %>
	hdr_content = "<%= escape_javascript(render(:partial => 'cards/list_header', :locals => {:card => card} )) %>"
	if $('.cd-date-hdr').size() == 0
		$('.cd-list').append(hdr_content)
		# data. representation of the data- attr
	if parseInt($('.cd-date-hdr:last').data('date') ) > <%= head_date_data %> 
		$('.cd-list-item:last').after (index) ->
			alert(hrd_content)			
			$(this).after(hdr_content)
	else
		$('.cd-date-hdr').each (index) -> 
			if parseInt($(this).data('date') ) < <%= head_date_data %>
				$(this).before(hdr_content)

# There now should always be a header to append to
item = $("<%= escape_javascript(render(:partial => 'list_detail', :locals => {:head_date_data => head_date_data})) %>")
header = $(".cd-date-hdr[data-date='<%= head_date_data%>']")
if header.size() > 1
	header = header[0]
header.after (index) ->
	item.addClass('new-list-item')
	$(this).after(item)
	item.slideDown('slow').removeClass('new-list-item')
newnum = $(".cd-list-item[data-date='<%= head_date_data%>']").size()
header.find('span').text(newnum)
# alert("newnum: " + newnum + "curr" + currentnum + "Length: " + $(this).length ) 

# now, RESET the form
$('#card_card_tags').tokenInput('clear')
$('form').get(1).reset()

# get a new cloud tag list
@populateTagCloud()

@getCardCounters()