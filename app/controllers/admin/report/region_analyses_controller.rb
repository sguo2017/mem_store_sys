class Admin::Report::RegionAnalysesController < AdminController
  def index
	@data = User.select("province,count(1) as count")
				.group(:province)
				.order("count DESC")
  end
end
