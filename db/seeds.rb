# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

moma = Account.create(:name => 'moma')
(0..3).each do |i|
  Artifact.create(:id => "art00#{i}", :account => moma)
end

gsapp = Account.create(:name => 'gsapp')
%w[4141 4379 4525 4542 4615 4718 4720 4731 4748 4793 4812 4813 4814].each do |i|
  Artifact.create(:id => "gsapp#{i}", :account => gsapp)
end