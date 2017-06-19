# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.profile_submit_button').click ->  

	 
	  	if !/^1\d{10}$/.test($('#user_phone_num').val()) 
	  			alert("号码格式不对") 
	  			return	false

	    return true