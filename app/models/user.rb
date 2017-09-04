class User < ApplicationRecord
  has_many :score_histories
  has_many :qr_code_scan_histories
  has_many :lotteries
  belongs_to :mem_group
  belongs_to :store
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_find :after_finded_callback

    def after_finded_callback

    end         

    #加积分 变级别<<
    # score       积分余额
    # score_total 累计积分:累计积分主要是一直累加的，用来计算等级
    def changeScore(param)
    	self.score = self.score + param
        if param > 0
    	   self.score_total = self.score_total + param
        end
    	@mem_levels = MemLevel.all.order("score ASC")
    	@mem_levels.each do |l|
    		# logger.debug "18 l.score #{l.score} l.level #{l.level}"
    		if self.score_total < l.score
    			# logger.debug "20 user.score #{self.score} l.score #{l.score} l.level #{l.level}"
    			self.level = l.code
    			break 
    		end
    	end
    	self.save
    end
    #加积分 变级别>>

    #抽奖活动送红包<<
    def lotteryredpacket(param)
        user_info = Hash.new
        user_info["openid"] = self.openid
        money = param
        return Wxinterface.send_redpacket(user_info,money)
    end
    #抽奖活动送红包>>

    #保存微信信息<<
    def saveWxUserInfo(params)
        self.openid = params["openid"]
        self.headimgurl = params["headimgurl"]   
        nickname = params["nickname"]  
        nickname = nickname.gsub /[\u{1F300}-\u{1F64F}\u{1F680}-\u{1F6FF}\u{1F1E6}-\u{1F1FF}
\u231A\u231B\u23E9-\u23EC\u23F0\u23F3
\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26B3-\u26BD\u26BF-\u26E1\u26E3-\u26FF
\u2705\u270A\u270B\u2728\u274C\u274E\u2753\u2757\u2795\u2796\u2797\u27B0\u27BF
\u{1F1E6}-\u{1F1FF}]/x, '*'   
        self.nickname = nickname
        self.name = nickname 
        self.sex = params["sex"] 
        self.language = params["language"]
        self.district = params["district"]
        self.city = params["city"]
        self.province = params["province"]
        self.country = params["country"]
        self.save    
    end
    #保存微信信息>>

 
end
