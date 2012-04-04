require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'data_mapper'

puts "#{Dir.pwd}/adserver.db"
DataMapper::setup(:default, "sqlite:#{Dir.pwd}/adserver.db")

class Ad
  include DataMapper::Resource

  property :id,           Serial
end

DataMapper.finalize
DataMapper.auto_upgrade!
