class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :phone_access_admin

  def phone_access_admin  	
    @user = current_user 
    #前端用户从前端跳转过来的 重新跳转到前端
    unless @user.admin 
     	redirect_to [:phone, 'homepages'] 
    end
  end

end
