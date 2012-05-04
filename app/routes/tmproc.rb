app do

  # not very RESTful, but alas... TextMarks API
  # Text 'Art001 Dislike' or 'Bond007 Like'
  get '/users/:phone_number/votes/:message' do
    user = User.first_or_create(:phone => params[:phone_number])
    user.update(:phone_id => params[:serial])

    message = params[:message].split('+')
    if message.size == 2
      id, rating = message.first.downcase, message.last.downcase.to_sym
    elsif message.size == 1
      last_vote = user.votes.last
      id = last_vote.artifact.id
      rating = (message.first.upcase == 'Y') ? :like : :dislike
      return if last_vote.value == rating
      last_vote.cancel.save
    end

    artifact = Artifact.get(id)
    return "Sorry, we don't have an artifact '#{id}'" if artifact.nil?

    user.votes.create(:value => rating, :artifact => artifact)

    # Questions composed such that Yes = Like and No = Dislike
    likes = artifact.votes.uncancelled.like.count
    dislikes = artifact.votes.uncancelled.dislike.count
    if likes > dislikes
      if rating == :like
        msg = "You've just joined the crowd. Are you sure you want to do that?"
      elsif rating == :dislike
        msg = "Odd, you're not following the others. Would you like to?"
      end
    elsif likes < dislikes
      if rating == :like
        msg = "Odd, you're not following the others. Stay in the minority?"
      elsif rating == :dislike
        msg = "You've just joined the crowd. Help out the little guy?"
      end
    else
      if rating == :like
        msg = "You just leveled the playing field. Did you mean to do that?"
      elsif rating == :dislike
        msg = "Darn, you just leveled the playing field. Do you want to change your vote?"
      end
    end

    "#{id}\nLikes: #{artifact.votes.like.count}\nDislikes: #{artifact.votes.dislike.count}\n\n#{msg}"
  end
end