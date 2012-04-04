class Artifact
  include DataMapper::Resource

  property :id,     Serial
  property :symbol, String

  has n, :votes
  belongs_to :account
end