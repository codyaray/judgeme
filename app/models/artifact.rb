class Artifact
  include DataMapper::Resource

  property :id, String, :key => true

  has n, :votes
  belongs_to :account
end