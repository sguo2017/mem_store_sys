class Admin::Report::MonthScansController < AdminController
    before_action :forbid_store_manager
	def index
		@data = Array.new(6)   #存放近六月的对应的扫码总数
		@date = Array.new(6)   #存放近六月的日期 （且日期为那一月的最后一天）
        for i in 0..5
            if Date.today.month-i > 0
            		@date[5-i] = Date.civil(Date.today.year, Date.today.month-i  , -1)
            		#推算前 i 月的最后一天日期时，若当月递减 i 个月后扔大于 0，则年份还是当前年份
            else 
            		@date[5-i] = Date.civil(Date.today.year-1, Date.today.month-i  , -1)
            		#推算前 i 月的最后一天日期时，若当月递减 i 个月后小于 0，则年份递减一，即上一年
            end
        end	

        for i in 0..5
        	count = 0
			count = QrCodeScanHistory.where("created_at >= ? and created_at <= ?",@date[i].at_beginning_of_month,@date[i])		
			@data[i] = count.length
			#通过计算第 i 月的第一天到最后一天来统计当月扫码数
		end
	end
end
