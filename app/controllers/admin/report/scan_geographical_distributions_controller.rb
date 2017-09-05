class Admin::Report::ScanGeographicalDistributionsController < AdminController
	skip_load_and_authorize_resource
    before_action :null_resource_authorize
	def index
		@date = params[:date]
		if @date.blank?
			@date = Time.now - 1.day
		else
			@date = Time.parse(@date)
		end
		@date = @date.beginning_of_day
		@data = User.select("province,count(1) as count")
				.joins(:qr_code_scan_histories)
				.where("qr_code_scan_histories.created_at >= ? and qr_code_scan_histories.created_at < ?",@date,@date+1.day)
				.group(:province)
				.order("count DESC")
				.limit('10')
		puts @data.to_json
		puts @date.strftime('%Y-%m-%d')
	end
end