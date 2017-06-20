class Const
  GOODS_SHOW_ADDR = "http://47.93.186.221:8081"
  STORES_SHOW_ADDR = "http://47.93.186.221:8081"
  ACTIVITY_SHOW_PAGE = {:base => "base", :award => "award", :cfg => "cfg"} 
  #短信有效时间
  SMS_TIME_LIMIT=5
  #初始化奖项
  AWARD_COUNT=10
  #抽奖机会
  CHANCE_DRAE_COUNT = 50
  #抽奖返回信息提示
  LOTTERY_MSG = {:no_chance => "您今天抽奖机会用完了，改天再来吧！", :unknown => "未知错误，请联系管理员"}
  #活动状态
  ACTIVITY_STATUS = {:effect => "00A", :expiration => "00X"}
  #门店类型
  BOOLEAN_LIST = [['自营', 'self'], ['社会', 'social']]

end
