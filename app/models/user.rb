class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :score_histories
  has_many :lotteries
  belongs_to :mem_group
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #加积分 变级别<<
  def changeScore(param)
  	self.score = self.score + param
  	self.score_total = self.score_total + param
  	@mem_levels = MemLevel.all.order("score ASC")
  	@mem_levels.each do |l|
  		# logger.debug "18 l.score #{l.score} l.level #{l.level}"
  		if self.score < l.score
  			# logger.debug "20 user.score #{self.score} l.score #{l.score} l.level #{l.level}"
  			self.level = l.code
  			break 
  		end
  	end
  	self.save
  end
  #加积分 变级别>>

  #保存微信信息<<
  def saveWxUserInfo(params)
      self.openid = params["openid"]
      self.headimgurl = params["headimgurl"]
      self.nickname = params["nickname"]
      self.name = params["nickname"]
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
