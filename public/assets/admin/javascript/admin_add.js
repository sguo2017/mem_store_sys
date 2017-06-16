$('#modal-users').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('mem_group') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  $(modal.find('.modal-body input[type=radio]')).each(function(){
  	$(this).removeProp("checked")
  	 if($(this).val() == recipient){
  	 	$(this).prop('checked', true)
  	 }
  })
  var action_url = "/admin/users/" + button.data('user')
  $("#chg_memgroup_form").prop("action",action_url)
})
$(document).ready(function(){
	$('input[name=authenticity_token]').val($('meta[name=csrf-token]').attr('content'))
})
