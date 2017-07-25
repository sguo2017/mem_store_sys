class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :phone_access_admin    
    before_action :menu_active

  def phone_access_admin    
    @user = current_user 
    #前端用户从前端跳转过来的 重新跳转到前端
    unless @user.admin 
        redirect_to [:phone, 'homepages'] 
    end

  end

  def menu_active    
    @current_uri = request.fullpath
    @current_nav = @current_uri[/^\/admin\/([a-z_]+)[\?\/]{0,1}.*/,1].to_s
    if @current_nav.blank?
        logger.debug "error! current_nav is blank!!!"
    else
        logger.debug "@current_nav  #{@current_nav}"
    end
    @goods_menu = ["goods_catalogs","good_instances"]
    @user_menu = ["lotteries", "score_histories", "mem_groups", "red_packet_histories"]
    @bonus = ["bonus_changes", "mem_levels"]
    @report = ["report","qr_code_scan_histories"]
	@config_menu = ["config_table_infos"]
    if @goods_menu.include?(@current_nav) 
        @current_nav = "goods"
    elsif @user_menu.include?(@current_nav)
        @current_nav = "users"
    elsif @bonus.include?(@current_nav)
        @current_nav = "bonus"
    elsif @report.include?(@current_nav)
        @current_nav = "report"
	elsif @config_menu.include?(@current_nav)
        @current_nav = "config_menu"
    end
  end

end