class User
  include DataMapper::Resource
  
  property :id,       Serial
  property :name,     String
  property :username, String, :unique => true
  property :email,    String, :unique => true, :format => :email_address
  property :phone,    String, :unique => true
  property :phone_id, String, :unique => true
  property :crypted_password, String

  has n, :votes
  belongs_to :account, :required => false
end