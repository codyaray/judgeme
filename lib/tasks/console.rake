desc "Start the JudgeMe console"
task :console do
  puts "Welcome to JudgeMe"
  APP_ROOT = './config/boot.rb'
  exec "irb -r irb/completion -r #{APP_ROOT} --simple-prompt"
end