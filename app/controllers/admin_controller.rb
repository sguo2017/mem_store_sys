class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :phone_access_admin

  def phone_access_admin  	
    @user = current_user 
    #前端用户从前端跳转过来的 重新跳转到前端
    unless @user.admin 
     	redirect_to [:phone, 'homepages'] 
    end
    @current_uri = request.fullpath
    @current_nav = @current_uri[/^\/admin\/([a-z_]+)[\?\/]{0,1}.?*/,1].to_s
    if @current_nav.blank?
    	 puts "error! current_nav is blank!!!"
    end
    @goods_menu = ["goods_catalogs"]
    @user_menu = ["lotteries", "score_histories", "mem_groups"]
    @bonus = ["bonus_changes", "mem_levels"]
    if @goods_menu.include?(@current_nav) 
    	@current_nav = "goods"
    elsif @user_menu.include?(@current_nav)
    	@current_nav = "users"
    elsif @bonus.include?(@current_nav)
    	@current_nav = "bonus"
    end

	end
end
