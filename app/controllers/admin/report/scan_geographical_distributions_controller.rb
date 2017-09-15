class Admin::Report::ScanGeographicalDistributionsController < AdminController
    before_action :forbid_super_admin
	def index
		@date = params[:date]
		if @date.blank?
			@date = Time.now - 1.day
		else
			@date = Time.parse(@date)
		end
		@date = @date.beginning_of_day
		@data = QrCodeScanHistory.select("province,count(1) as count")
				.where("created_at >= ? and created_at < ?",@date,@date+1.day)
				.group(:province)
				.order("count DESC")
				.limit('10')
		puts @data.to_json
		puts @date.strftime('%Y-%m-%d')
	end
end