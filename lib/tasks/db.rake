desc "Operations on the DB"
namespace :db do

  desc "migrate the DB"
  task :migrate do
    DataMapper.auto_migrate!
  end

  desc "upgrade the DB"
  task :upgrade do
    DataMapper.auto_upgrade!
  end
end