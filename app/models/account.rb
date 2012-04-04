class Account
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :created_at, DateTime, :default => lambda { |p,s| DateTime.now }

  has n, :users
  has n, :artifacts
end