app do
  get '/' do
    @artifacts = Artifact.all
    haml :index
  end
end