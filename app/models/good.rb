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
			if @redpacket.catalog_iii == "samll"
				#计算概率控制数
				count1 = @redpacket.rate
				#统计已中奖数量
				m = @money*100
				rs = RedPacketHistory.find_by_sql("select t.* from (SELECT h.money from red_packet_histories h where obj_id=#{self.id} ORDER BY created_at desc LIMIT 10000) t where t.money=#{m}")
				count2 = rs.length
				p "count2: #{count2}"
				if count2 > count1 - 1
					p "重新抽取"
					return self.calculateMoney
				end
                
			end
			return @money
		else
			return 0
		end
	end
end
