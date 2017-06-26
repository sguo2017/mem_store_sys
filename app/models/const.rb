
class Const
  GOODS_SHOW_ADDR = "http://47.93.186.221:8081"
  STORES_SHOW_ADDR = "http://47.93.186.221:8081"
  ACTIVITY_SHOW_PAGE = {:base => "base", :award => "award", :cfg => "cfg"} 
  #短信有效时间
  SMS_TIME_LIMIT=1
  #初始化奖项
  AWARD_COUNT=10
  #抽奖机会
  CHANCE_DRAE_COUNT = 5
  #抽奖返回信息提示
  LOTTERY_MSG = {:no_chance => "您今天抽奖机会用完了，改天再来吧！", :unknown => "未知错误，请联系管理员"}
  #活动状态
  ACTIVITY_STATUS = {:effect => "00A", :expiration => "00X"}
  #门店类型
  BOOLEAN_LIST = [['自营', 'self'], ['社会', 'social']]

  #短信接口
  SMS_SEND_URL = "https://sms.yunpian.com/v2/sms/tpl_single_send.json"
  SMS_SEND_API_KEY = "cdefecbad01205cd9de33b1ac0343c41"
  SMS_TMEPLE = "【德高工长巴】您好！您本次领取会员卡的验证码为：%s"
  TPL_ID = "1846372"

  #WX
  module WXConfig
    APPID = "wx649eb094afb490f5"
    SECRET = "0a517e7833a360b634a9b90850ae96b1"
    GRANT_TYPE = "client_credential"
    SIGNATURE = ""

    #ACCESS_TOKEN = "https://api.weixin.qq.com/sns/oauth2/access_token?"
    ACCESS_TOKEN = "https://api.weixin.qq.com/cgi-bin/token?"
    JS_ACCESS_TOKEN = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?"
  end

  #新用户注册，系统自动生成邮箱，非空字段
  SYSTEM_EMAIL = "system_generation_email@domain.com"
end
