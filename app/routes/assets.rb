app do
  get '/javascripts/:javascript.js' do
    content_type 'text/javascript', :charset => 'UTF-8'
    coffee "javascripts/#{params[:javascript]}".to_sym
  end

  get '/stylesheets/:stylesheet.css' do
    content_type 'text/css', :charset => 'UTF-8'
    scss "stylesheets/#{params[:stylesheet]}".to_sym
  end
end