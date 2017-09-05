class Admin::Report::TrendAnalysesController < AdminController
	skip_load_and_authorize_resource
    before_action :null_resource_authorize
	def index
		_type = ["active_mem","recently_register_mem","code_scan_rate","red_pactket_data","score_date","repay_rate","mem_turnover_rate"]
		@analyses_type = params[:analyses_type]
		if @analyses_type.blank?
			@analyses_type = "active_mem"
		end
		@day_count = params[:day_count]
		if @day_count.blank?
			@day_count = 10
		end
		case @analyses_type
		when "active_mem" #活跃会员
			@data = Array.new(@day_count)
			@date = Array.new(@day_count)
			for i in 0..@day_count-1
				@date[i] = (Time.now - 1.day).at_end_of_day + (i + 1 - @day_count).day
				user = QrCodeScanHistory.select('user_id').distinct.where("created_at > ? and created_at <= ?",@date[i]-60.day,@date[i])
				puts user.to_json
				@data[i] = user.length
			end
		when "recently_register_mem" #新注册会员
			@data = Array.new(@day_count)
			@date = Array.new(@day_count)
			for i in 0..@day_count-1
				@date[i] = (Time.now - 1.day).at_end_of_day  + (i + 1 - @day_count).day
				user = User.select('id').distinct.where("created_at > ? and created_at <= ?",@date[i]-1.day,@date[i])
				puts user.to_json
				@data[i] = user.length
			end
		when "code_scan_rate" #参与扫码会员
			@data = Array.new(@day_count)
			@date = Array.new(@day_count)
			for i in 0..@day_count-1
				@date[i] = (Time.now - 1.day).at_end_of_day  + (i + 1 - @day_count).day
				user = QrCodeScanHistory.select('user_id').distinct.where("created_at > ? and created_at <= ?",@date[i]-1.day,@date[i])
				puts user.to_json
				@data[i] = user.length
			end
		end
	end
end
