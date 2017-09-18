class Const
  GOODS_SHOW_ADDR = "http://gzb.davco.cn" #"http://47.93.186.221:8081"
  STORES_SHOW_ADDR = "http://gzb.davco.cn" #"http://47.93.186.221:8081"
  ACTIVITY_SHOW_PAGE = {:base => "base", :award => "award", :cfg => "cfg"} 
  #初始化奖项
  AWARD_COUNT=10
  #抽奖消耗积分
  SCORE_COST = 10
  #抽奖机会
  CHANCE_DRAE_COUNT = 100
  #抽奖返回信息提示
  LOTTERY_MSG = {:no_chance => "您今天抽奖机会用完了，改天再来吧！", :score_not_enough => "积分不足，请加油获取积分！",:unknown => "未知错误，请联系管理员"}
  #活动状态
  ACTIVITY_STATUS = {:effect => "00A", :expiration => "00X"}


  #新用户注册，系统自动生成邮箱，非空字段
  SYSTEM_EMAIL = "system_generation_email@domain.com"


  #短信接口<<
  SMS_TMEPLE = "【德高工长巴】您好！您本次领取会员卡的验证码为：%s"
  SMS_TIME_LIMIT=1  #短信有效时间
  #短信接口<< 

  #supper_manager超级管理员，store_manager店铺管理员，nil_manager普通会员
  #管理员类型<<
  MANAGER = {:supper_manager => 1, :store_manager => 2, :nil_manager => 0 }
  #管理员类型<<

  #WX<<
  module WXConfig
    # GRANT_TYPE = "client_credential"
    GRANT_TYPE = "authorization_code"
    SIGNATURE = ""
  end
  #WX>>  

  #下拉框的可选项<<
  module SelectOption
    #商品发布状态
    GOODS_STATUS =  [["否", "0"], ["是", "1"]]
    #门店类型
    BOOLEAN_LIST = [['自营', 'self'], ['社会', 'social']]
    #奖品配置
    AWARD_CFG_LIST = [["积分", "score"],["现金","money"]]
    #用户性别
    USER_SEX = [["男", "1"], ["女", "0"]]
    #用户状态
    USER_STATUS = [["正常", "00A"], ["已冻结", "00X"], ["已注销", "00H"]]
    #商品是否状态
    GOODS_PROMOTION_STATUS =  [["否", false], ["是", true]]
  end
  #下拉框的可选项>>

end
