class Admin::Report::MemAnalysesController < AdminController
  def index
    @qryType = params[:qryType]
    if @qryType.blank?
        @qryType = "1"
    end
    
    case @qryType
    when "1" 
        #统计各年龄阶段人数
        minors=0
        youth=0
        middle_age=0
        old=0
        other=0
        users=User.where([ "id > ?  ",  1 ])
        users.each do |t|
            unless t.birthday.nil?
                age = (DateTime.now - t.birthday) / 365.25
                case age
                when 0..17 then minors+=1  #未成年人
                when 18..40 then youth+=1  #青年人
                when 41..65 then middle_age+=1  #中年人
                else old+=1  #老年人
                end      
            else 
                other+=1  #其他情况，如未知生日，无法计算年龄
            end
        end 
        @data = [
            {value:minors, name:'未成年'},
            {value:youth, name:'青年'},
            {value:middle_age, name:'中年'},
            {value:old, name:'老年'},
            {value:other, name:'其它(未知年龄)'}
          ]
        # logger.debug("未成年人数: #{@minors}")     
    when "2" #性别  
        #统计性别人数
        men=User.where([ "id > ? and sex = ? ", 1 , 1 ])
        men_num=men.length
        
        women=User.where([ "id > ? and sex = ? ", 1 , 0 ])
        women_num=women.length
        @data = [
            {value:men_num, name:'男性'},
            {value:women_num, name:'女性'},
          ]
    when "3" 
         #统计等级人数
        level_v1=User.where([ "id > ? and level = ? ", 1 , 'V1' ])
        level_v1_num=level_v1.length
        
        level_v2=User.where([ "id > ? and level = ? ", 1 , 'V2' ])
        level_v2_num=level_v2.length

        level_v3=User.where([ "id > ? and level = ? ", 1 , 'V3' ])
        level_v3_num=level_v3.length

        level_v4=User.where([ "id > ? and level = ? ", 1 , 'V4' ])
        level_v4_num=level_v4.length

         @data = [
            {value:level_v1_num, name:'白银会员'},
            {value:level_v2_num, name:'黄金会员'},
            {value:level_v3_num, name:'白金会员'},
            {value:level_v4_num, name:'钻石会员'}
          ]
            
    end
    # @data=
    # 	[
    #         {value:335, name:'直接访问'},
    #         {value:310, name:'邮件营销'},
    #         {value:234, name:'联盟广告'},
    #         {value:135, name:'视频广告'},
    #         {value:1548, name:'搜索引擎'}
    #       ]
  end
end
