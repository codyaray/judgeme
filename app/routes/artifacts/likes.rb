app do
  get '/artifacts/:id/ratings' do
    @num_likes = Artifact.get(param[:id]).votes.like
    
    haml :'artifacts/likes'
  end
end