app do
  get '/artifacts/:id' do
    @artifact = Artifact.get(params[:id])
    redirect not_found if @artifact.nil?
    @num_likes = @artifact.votes.like.count
    @num_dislikes = @artifact.votes.dislike.count
    haml :artifact
  end
end