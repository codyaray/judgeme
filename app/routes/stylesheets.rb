app do
  get '/stylesheets/:stylesheet.css' do
    content_type 'text/css', :charset => 'UTF-8'
    scss "stylesheets/#{params[:stylesheet]}".to_sym
  end
end