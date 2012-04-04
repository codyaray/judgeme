app do
  get '/javascripts/:javascript.js' do
    content_type 'text/javascript', :charset => 'UTF-8'
    coffee "javascripts/#{params[:javascript]}".to_sym
  end
end