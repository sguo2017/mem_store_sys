# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', ->
  $('#showUser2Code').click ->
    $('#user2code').show()
  $('#hideUser2Code').click ->
    $('#user2code').hide()
  $('.ico-scan').click ->
    uploadLocation()
    wx.scanQRCode
      needResult: 0
      scanType: [
        'qrCode'
        'barCode'
      ]
      success: (res) ->
        console.log res.resultStr
    return
  return

	  	    


