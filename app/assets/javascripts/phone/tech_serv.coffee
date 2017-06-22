# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.ico-scan').click -> 
	  	wx.scanQRCode({
          needResult: 0, 
          scanType: ["qrCode","barCode"], 
          success: (res) ->              
              alert(res.resultStr)
          
      	}); 



