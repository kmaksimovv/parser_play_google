require 'sequel'
require './db_conn'
require './lib/app.rb'
require './lib/rating.rb'
require './lib/helper.rb'

name, count = ARGV

app = App.find(name: name.downcase)

if app
  app_ratings = Rating.where(app_id: app.id).order(Sequel.desc(:created_at)).limit(count).all
  app_history_ratings(app, *app_ratings)
else
  puts "Such an application was not found in the database"
end


