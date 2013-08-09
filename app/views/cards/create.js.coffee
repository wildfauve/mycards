<% head_date_data = @card.date_made.strftime('%s')  %> 

# clear errors just in case
$('#new-status').empty()

# Create a header to place the card item under
if $(".cd-date-hdr[data-date='<%= head_date_data%>']").length == 0
	<% card = @card %>
	hdr_content = "<%= escape_javascript(render(:partial => 'cards/list_header', :locals => {:card => card} )) %>"
	if $('.cd-date-hdr').size() == 0
		$('.cd-list').append(hdr_content)
		# data. representation of the data- attr
	else
		if parseInt($('.cd-date-hdr:last').data('date') ) > <%= head_date_data %>  #need to insert at the end
			last_date = parseInt($('.cd-date-hdr:last').data('date'))
			if parseInt($('.cd-list-item:last').data('date')) == last_date  # needs to be after the list item
				$('.cd-list-item:last').after(hdr_content)
			else
				$('.cd-date-hdr:last').after(hdr_content) # no list items, so stright after the other header
		else
			$('.cd-date-hdr').each (i, element) => 
				if parseInt($(element).data('date')) < <%= head_date_data %>
					$(element).before(hdr_content)
					return false

# There now should always be a header to append to
item = $("<%= escape_javascript(render(:partial => 'list_detail', :locals => {:head_date_data => head_date_data})) %>")
header = $(".cd-date-hdr[data-date='<%= head_date_data%>']:first")
header.after () ->
	item.addClass('new-list-item')
	$(this).after(item)
	item.slideDown('slow').removeClass('new-list-item')
#newnum = $(".cd-list-item[data-date='<%= head_date_data%>']").size()
newnum = <%= @card.total_made_on_this_date %>
header.find('span').text(newnum)

# now, RESET the form
$('#card_card_tags').tokenInput('clear')
$('#new_card')[0].reset()

# get a new cloud tag list
@populateTagCloud()

@getCardCounters()