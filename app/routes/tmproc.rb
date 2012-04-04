app do
  # not very RESTful, but alas... TextMarks API
  # Text 'Art001 Dislike' or 'Bond007 Like'
  get '/users/:phone_number/votes/:message' do
    message = params[:message].split('+')
    symbol, rating = message.first, message.last.upcase

    user = User.first_or_create(:phone => params[:phone_number])
    user.update(:phone_id => params[:serial])
    artifact = Artifact.first(:symbol => symbol)
    return "Sorry, we don't have an artifact '#{symbol}'" if artifact.nil?
    user.votes.create(:value => rating.downcase.to_sym, :artifact => artifact)

    "Likes: #{artifact.votes.like.count}\nDislikes: #{artifact.votes.dislike.count}"
  end
end