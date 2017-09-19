class Good < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	mount_uploader :info, AvatarUploader
	belongs_to :goods_catalog

	#计算商品扫码获得红包的金额数
	def calculateMoney()
		catalog_i = self.scan_catalog
		base_money = self.scan_base_money
		if catalog_i.present? && base_money.present?
			@redpackets = RedPacketBaseRate.where("catalog_i=?",catalog_i)
			pdf = []
			@redpackets.each do |rp|
				rate = rp.rate.to_f/10000.00
				pdf.push(rate)
		    end
		    cdf = pdf;
			cdf.each_with_index do |item, index|
				unless index == 0 
				  cdf[index] += cdf[index-1]
				end
			end

			#Force set last cdf to 1, preventing floating-point summing error in the loop.
			cdf[cdf.size - 1] = 1.00;
			y = rand(100)/100.to_f;
			item = 0
			cdf.each_with_index do |p, i|
				if y < p.to_f
				  item = i
				  break
				end
			end
			@redpacket = @redpackets[item]
			@money = @redpacket.val + @redpacket.catalog_ii*base_money
			return @money
		else
			return 0
		end
	end
end
