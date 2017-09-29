
function set_store_admin(store_id,user_id){
	$.ajax('/admin/stores/set_store_admin', {
	  type: 'POST',
	  dataType: 'json',
	  data: {
	    store_id: store_id,
	    user_id: user_id
	  },
	  success: function(data, textStatus, jqXHR) {
	  	var msg = data
	  	alert(msg.notice)
	    },
	  error: function(jqXHR, textStatus, errorThrown) {
	  }
	});
}