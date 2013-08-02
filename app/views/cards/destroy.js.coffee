<% head_date_data = @card.date_made.strftime('%s')  %> 
del_item = $('#<%= @card.id%>')
header = $(".cd-date-hdr[data-date='<%= head_date_data%>']")
var currentnum = header.find('span').text()
del_item.slideUp()
del_item.remove()
var newnum = $(".cd-list-item[data-date='<%= head_date_data%>']").size()
header.find('span').text(newnum)
# Update the Tag Cloud
# get a new cloud tag list
@populateTagCloud()

# Update the Count of cards
@getCardCounters()

