desc "Start the JudgeMe console"
task :console do
  puts "Welcome to JudgeMe"
  APP_ROOT = File.expand_path('../../../boot', __FILE__)
  exec "irb -r irb/completion -r #{APP_ROOT} --simple-prompt"
end