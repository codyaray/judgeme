class Vote
  include DataMapper::Resource

  property :id,           Serial
  property :value,        Enum[:like, :dislike], :required => true
  property :submitted_at, DateTime, :default => lambda { |p,s| DateTime.now }
  property :cancelled,    Boolean, :default => false
  property :cancelled_at, DateTime
  
  belongs_to :user
  belongs_to :artifact

  def cancel
    self.cancelled = true
    self.cancelled_at = DateTime.now
    self
  end

  def cancelled?
    self.cancelled
  end

  def self.like
    all(:value => :like)
  end

  def self.dislike
    all(:value => :dislike)
  end

  def self.cancelled
    all(:cancelled => true)
  end

  def self.uncancelled
    all(:cancelled => false)
  end
end