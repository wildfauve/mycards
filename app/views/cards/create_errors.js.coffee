errors = $("<%= escape_javascript(render(:partial => "shared/flash", :locals => {:flashs => flash} )) %>")
$('#new-status').html(errors)
