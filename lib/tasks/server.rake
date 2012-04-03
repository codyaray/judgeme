desc "Start the JudgeMe server"
task :server do
  exec "unicorn -c config/unicorn.conf"
end