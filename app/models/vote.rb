class Vote
  include DataMapper::Resource

  property :id,           Serial
  property :value,        Enum[:like, :dislike], :required => true
  property :submitted_at, DateTime, :default => lambda { |p,s| DateTime.now }
  
  belongs_to :user
  belongs_to :artifact

  def self.like
    all(:value => :like)
  end

  def self.dislike
    all(:value => :dislike)
  end
end