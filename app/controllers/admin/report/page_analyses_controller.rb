class Admin::Report::PageAnalysesController < AdminController
	skip_load_and_authorize_resource
    before_action :null_resource_authorize
  def index
    
  end
end
