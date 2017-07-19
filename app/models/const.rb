class Const
  GOODS_SHOW_ADDR = "http://gzb.davco.cn" #"http://47.93.186.221:8081"
  STORES_SHOW_ADDR = "http://gzb.davco.cn" #"http://47.93.186.221:8081"
  ACTIVITY_SHOW_PAGE = {:base => "base", :award => "award", :cfg => "cfg"} 
  #初始化奖项
  AWARD_COUNT=10
  #抽奖机会
  CHANCE_DRAE_COUNT = 100
  #抽奖返回信息提示
  LOTTERY_MSG = {:no_chance => "您今天抽奖机会用完了，改天再来吧！", :unknown => "未知错误，请联系管理员"}
  #活动状态
  ACTIVITY_STATUS = {:effect => "00A", :expiration => "00X"}


  #新用户注册，系统自动生成邮箱，非空字段
  SYSTEM_EMAIL = "system_generation_email@domain.com"


  #短信接口<<
  SMS_SEND_URL = "https://sms.yunpian.com/v2/sms/tpl_single_send.json"
  SMS_SEND_API_KEY = "cdefecbad01205cd9de33b1ac0343c41"
  SMS_TMEPLE = "【德高工长巴】您好！您本次领取会员卡的验证码为：%s"
  TPL_ID = "1846372"
  SMS_TIME_LIMIT=1  #短信有效时间
  #短信接口<< 

  #WX<<
  module WXConfig
    APPID = "wx649eb094afb490f5"
    SECRET = "86f9b7bc167aa6cd07ce068f3a905c13"
    # GRANT_TYPE = "client_credential"
    GRANT_TYPE = "authorization_code"
    SIGNATURE = ""

    RED_PACKET_ADDR = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack"
    ACCESS_TOKEN_ADDR = "https://api.weixin.qq.com/sns/oauth2/access_token?"
    USER_INFO_ADDR = "https://api.weixin.qq.com/sns/userinfo?"
    JS_TIKET_ADDR = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?"
    AUTH_ADDR = "https://open.weixin.qq.com/connect/oauth2/authorize?"
  end
  #WX>>  

  #下拉框的可选项<<
  module SelectOption
    #商品发布状态
    GOODS_STATUS =  [["否", "0"], ["是", "1"]]
    #门店类型
    BOOLEAN_LIST = [['自营', 'self'], ['社会', 'social']]
    #奖品配置
    AWARD_CFG_LIST = [["积分", "积分"]]
    #用户性别
    USER_SEX = [["男", "1"], ["女", "0"]]
    #用户状态
    USER_STATUS = [["正常", "00A"], ["已冻结", "00X"], ["已注销", "00H"]]
    #商品是否状态
    GOODS_PROMOTION_STATUS =  [["否", false], ["是", true]]
  end
  #下拉框的可选项>>

end
