require_relative 'setup'
require 'sequel'

namespace :db do
  task :setup do
    Sequel.connect(database_url) do |db|
      db.run(File.read('db/create_tables.sql', 'r'))
    end
  end
end
