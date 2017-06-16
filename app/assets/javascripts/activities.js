function tabs_item() {
	var tab_ids = ["tab1","tab2","tab3"];
	return tab_ids;
}
function activites(tid) {
	var	tab_ids = tabs_item();
	// $(".sub-navbar-nav li").click(function(e){
		var me = tid;
		var curr_index = $(me).index();
		$(".sub-navbar-nav li").each(function(){
			$(this).removeClass("active")
		})
		$(me).addClass("active");
		$(tab_ids).each(function(index) {
			$("#"+tab_ids[index]).hide()
		})
		$("#"+tab_ids[curr_index]).show()
		return false;
	// })
}
function activites_tabs_init(){
	var init_index = 0;
	var	tab_ids = tabs_item();
	$(tab_ids).each(function(index) {
		console.log(index)
			$("#"+tab_ids[index]).hide()
	})
	$("#"+tab_ids[init_index]).show()
}

$(document).ready(function(){
	//activites_tabs_init()
	//navbar_init();
	//activites();
})


// nav active 
function navbar_active (tid){
		var me = tid;
	$(".navbar-nav li").each(function(){
			$(this).removeClass("active")
		})
		$(me).addClass("active");
}
