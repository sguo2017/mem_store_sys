# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
###
$ ->
  $('#getSmsCode').click ->  
	    
	  	if '' == $('#recv_num').val() 
	  			alert("接受号码不能为空") 
	  			return	

	  	if !/^1\d{10}$/.test($('#recv_num').val()) 
	  			alert("号码格式不对") 
	  			return	

	    $.ajax '/phone/sms_sends',
	    type: 'POST'
	    dataType: 'json'
	    data: sms_send: {recv_num: $('#recv_num').val()}

	    success: (data, textStatus, jqXHR) ->
	    	if '200' == data.retcode 
		    	$('#getSmsCode').hide(); 
		    	$('.countdown_wrap').show(); 
		    	$('.countdown_num').countdown({until: '+60',compact:true, format: 's',onExpiry: liftOff});
	    	else

	    	alert(data.msg)

	    error: (jqXHR, textStatus, errorThrown) ->
	        alert(textStatus)	  	

	     liftOff = () ->
	      $('.countdown_wrap').hide(); $('#getSmsCode').show(); $('.countdown_num').countdown('destroy');

  $('.notice_close_btn').click -> $('.activation_popup_wrap').hide()

  $('.ico-scan').click -> wx.scanQRCode({
        	needResult: 0,
        	scanType: ["qrCode","barCode"],
        	success: (res) ->
              		console.log(res.resultStr)          
	  	});  
###

