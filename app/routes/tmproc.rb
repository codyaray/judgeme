app do
  # not very RESTful, but alas... TextMarks API
  get '/users/:phone_number/votes/:message' do
    "Thanks for your message! -C"
  end
end