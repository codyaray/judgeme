app do
  get '/' do
    @accounts = Account.all
    haml :'accounts/index'
  end
end