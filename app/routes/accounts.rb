app do
  get '/accounts' do
    @account = Account.all
    haml :'accounts/index'
  end

  get '/accounts/:id' do
    @account = Account.get(params[:id])
    @artifacts = @account.artifacts || []
    haml :'accounts/show'
  end
end