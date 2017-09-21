class Admin::Report::RegionAnalysesController < AdminController
    before_action :forbid_store_manager
  def index
	@data = User.select("province,count(1) as count")
				.group(:province)
				.order("count DESC")
  end
end
