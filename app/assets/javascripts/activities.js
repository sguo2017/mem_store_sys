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

function selectAcceptCfgs(cfg_id,cfg_val,obj,isCancle,cfg_input_id_field='#_sys_awardaccept_cfg_id',cfg_input_name_field='#_sys_awardaccept_cfg_name'){
	if(!isCancle){
		
		$(cfg_input_id_field).val(cfg_id.toString());
		$(cfg_input_name_field).val(cfg_val.toString());
		
		$(obj).html('取消');
		$(obj).removeClass('btn-primary');
		$(obj).addClass('btn-danger');
		$(obj).removeAttr('onclick');
		$(obj).unbind();
		$(obj).bind('click',function(){selectAcceptCfgs(cfg_id,cfg_val,obj,true);});
	}else{
		$(cfg_input_id_field).val(cfg_id.toString());
		$(cfg_input_name_field).val(cfg_val.toString());
		
		$(obj).html('选择');
		$(obj).removeClass('btn-danger');
		$(obj).addClass('btn-primary');
		$(obj).removeAttr('onclick');
		$(obj).unbind();
		$(obj).bind('click',function(){selectAcceptCfgs(cfg_id,cfg_val,obj,false);});
	}
}

function clearValue(identify){
	$(identify).val('');
}