# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$ ->
  $('#getSmsCode').click ->  
    $.ajax '/phone/sms_sends/new',
    type: 'GET'
    dataType: 'html'
    data: 'recv_num=' + 	$('#recv_num').val() ,
    error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
        $('body').append "Successful AJAX call: #{data}"
