class Admin::Report::RegionAnalysesController < AdminController
	skip_load_and_authorize_resource
    before_action :null_resource_authorize
  def index
	@data = User.select("province,count(1) as count")
				.group(:province)
				.order("count DESC")
  end
end
