$('#cd-list').hide()
$('#cd-list').html("<%= escape_javascript(render(:partial => 'cards/cards_list')) %>")
$('#cd-list').slideDown('slow')