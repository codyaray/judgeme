RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.dirname(__FILE__) + "/../config/boot"
Bundler.require(:default, :test)

# Test configuration

class Riot::Situation
  include RR::Adapters::RRMethods
  include Rack::Test::Methods

  def app
    JudgeMe.tap { |app| app.set :environment, :test }
  end
end
