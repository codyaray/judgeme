app do
  # not very RESTful, but alas... TextMarks API
  # Text 'Art001 Dislike' or 'Bond007 Like'
  get '/users/:phone_number/votes/:message' do
    message = params[:message].split('+')
    id, rating = message.first, message.last.upcase

    user = User.first_or_create(:phone => params[:phone_number])
    user.update(:phone_id => params[:serial])
    artifact = Artifact.get(id)
    return "Sorry, we don't have an artifact '#{id}'" if artifact.nil?
    user.votes.create(:value => rating.downcase.to_sym, :artifact => artifact)

    "Likes: #{artifact.votes.like.count}\nDislikes: #{artifact.votes.dislike.count}"
  end
end