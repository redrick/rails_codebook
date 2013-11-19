desc 'my plugins rake task'

namespace :cb do

  task :install do
    load "db/seeds.rb"
  end

end