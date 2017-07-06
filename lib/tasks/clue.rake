desc "清除会员积分历史和会员中奖纪录"
# 使用方式：清除会员数据(users中id大于2的数据);清除会员中奖纪录;清除积分兑换纪录
# 一、执行单一某方法：在当前工程根目录下  rake clue:Lottery
# 二、执行多个方法打包  rake data_clear

# 多个方法打包到任务 data_clear
task :data_clear do
Rake::Task["clue:User"].invoke
#调用clue命名空间下的User方法
Rake::Task["clue:BonusChange"].invoke
Rake::Task["clue:Lottery"].invoke
end

#clue命名空间下的各个方法声明
namespace :clue do  

  desc "Destroy User"
  task :User =>:environment do
  	 STDOUT.puts "Are you sure to destroy User? (y/n)"
     input = STDIN.gets.strip
     if input == 'y'
     	puts("hello User")
  	 else
        STDOUT.puts "Nothing done"
     end
  end

  desc "Destroy Lottery"
  task :Lottery =>:environment do
  	 STDOUT.puts "Are you sure to destroy Lottery? (y/n)"
     input = STDIN.gets.strip
     if input == 'y'
     	puts("hello Lottery")
  	 else
        STDOUT.puts "Nothing done"
     end
  end

  desc "Destroy BonusChange"
  task :BonusChange =>:environment do
  	 STDOUT.puts "Are you sure to destroy BonusChange? (y/n)"
     input = STDIN.gets.strip
     if input == 'y'
     	puts("hello BonusChange")
  	 else
        STDOUT.puts "Nothing done"
     end
  end

  desc "Destroy ScoreHistory"
  task :ScoreHistory =>:environment do
  	 STDOUT.puts "Are you sure to destroy ScoreHistory? (y/n)"
     input = STDIN.gets.strip
     if input == 'y'
     	puts("hello ScoreHistory")
  	 else
        STDOUT.puts "Nothing done"
     end
  end

end


# task :check,[:name] do |t, args|
#   STDOUT.puts "Are you sure to destroy #{args.name}? (y/n)"
#   input = STDIN.gets.strip
#   if input == 'y'
#     Rake::Task["#{args.name}"].invoke
#   else
#     STDOUT.puts "Nothing done"
#   end
# end