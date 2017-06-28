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

end
