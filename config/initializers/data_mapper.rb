module DataMapperInitializer
  def self.registered(app)
    app.configure(:development) { DataMapper.setup(:default, "sqlite:#{root_path('db','development.sqlite3')}") }
    app.configure(:production)  { DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:#{root_path('db', 'production.sqlite3')}") }
    app.configure(:test)        { DataMapper.setup(:default, 'sqlite3::memory:') }
  end
end