RACK_ENV = ENV["RACK_ENV"] ||= "development" unless defined? RACK_ENV

require File.dirname(__FILE__) + '/config/boot.rb'

# FileUtils.mkdir_p 'log' unless File.exists?('log')
# log = File.new("log/sinatra.log", "a")
# $stdout.reopen(log)
# $stderr.reopen(log)

# map "/reports" do
  # run Rack::Directory.new("tmp/daily_reports/")
# end
# use Rack::Static, :urls => ["/reports"], :root => "tmp/daily_reports"
use Rack::Reloader
run JudgeMe
