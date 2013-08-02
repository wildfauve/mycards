errors = $("<%= escape_javascript(render(:partial => "cards/create_errors", :locals => {:card => @card} )) %>")
$('#new-status').html(errors)
