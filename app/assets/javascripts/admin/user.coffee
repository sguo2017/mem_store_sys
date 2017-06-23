# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.lock-user-btn').click ->  
	    that = $(this);
	    user_id = $(this).data('user')
	    status = $(this).data('status')
	    if status == '00A'
	      status= '00X'
	    else if status == '00X'
	      status= '00A'	
	    url = '/admin/users/' + user_id + '.json'

	    $.ajax url,
		    type: 'patch'
		    dataType: 'json'
		    data: user: {status: status}
    		error: (jqXHR, textStatus, errorThrown) ->
        		console.log("AJAX Error: #{textStatus}")
    		success: (data, textStatus, jqXHR) ->
    			that.data('status',status)
    			if status == '00A'
    				that.children('.unlock-text').hide()
    				that.children('.lock-text').show()
    			else if status == '00X'
    				that.children('.lock-text').hide()
    				that.children('.unlock-text').show()

  $('.close-user-btn').click ->  
  		if confirm("确定注销?")
	    user_id = $(this).data('user')
	    status = '00H'	
	    url = '/admin/users/' + user_id + '.json'

	    $.ajax url,
		    type: 'patch'
		    dataType: 'json'
		    data: user: {status: status}
    		error: (jqXHR, textStatus, errorThrown) ->
        		console.log("AJAX Error: #{textStatus}")
    		success: (data, textStatus, jqXHR) ->
    			alert("注销成功")
    			console.log("AJAX success: #{data.msg}")
    			window.location.reload()
