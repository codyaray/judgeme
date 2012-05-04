app do

  get '/artifacts/:id/votes' do
    artifact = Artifact.get(params[:id])
    return "Sorry, we don't have an artifact '#{params[:id]}'" if artifact.nil?

    @likes = artifact.votes.uncancelled.like.count
    @dislikes = artifact.votes.uncancelled.dislike.count
    haml :votes
  end

  # not very RESTful, but alas... TextMarks API
  # Text 'Art001 Dislike' or 'Bond007 Like' (explicit)
  # Text 'C' to Change your last vote (contextual)
  get '/users/:phone_number/votes/:message' do
    user = User.first_or_create(:phone => params[:phone_number])
    user.update(:phone_id => params[:serial])

    message = params[:message].split('+')
    if message.size == 2      # explicit messaging
      id, rating = message.first.downcase, message.last.downcase.to_sym
    elsif message.size == 1   # contextual messaging
      return "Reply C to change your last vote" if message.first.upcase != 'C'
      last_vote = user.votes.last
      last_vote.cancel.save
      id = last_vote.artifact.id
      rating = change_vote(last_vote.value)
    end

    artifact = Artifact.get(id)
    return "Sorry, we don't have an artifact '#{id}'" if artifact.nil?

    user.votes.create(:value => rating, :artifact => artifact)

    likes = artifact.votes.uncancelled.like.count
    dislikes = artifact.votes.uncancelled.dislike.count
    if likes > dislikes
      if rating == :like
        msg = "You're following the crowd. If you want to stand out reply C to change your vote."
      elsif rating == :dislike
        msg = "You're not in the majority right now. Reply C to change to the winning team."
      end
    elsif likes < dislikes
      if rating == :like
        msg = "Odd, you're not following the others. Stay in the minority? Or reply C to change your vote."
      elsif rating == :dislike
        msg = "You've just joined the crowd. Why not help out the little guy and reply C to change your vote?"
      end
    else
      msg = "You just leveled the playing field. Did you mean to do that? If not reply C to change your vote."
    end

    "#{id}\nLikes: #{likes}\nDislikes: #{dislikes}\n\n#{msg}"
  end

  private

    def change_vote(vote)
      if vote == :like
        :dislike
      elsif vote == :dislike
        :like
      else
        :unknown
      end
    end

end