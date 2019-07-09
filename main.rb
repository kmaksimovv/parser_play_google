require 'sequel'
require './db_conn'

Dir[File.expand_path('lib/*.rb', __dir__)].each do |file|
  require file
end

link_app = ARGV

gps = GooglePlayService::ParsePageApp.new link_app.first

show_parse_app(gps)

find_app = App.find(name: gps.name.downcase)

if !find_app
  app = App.create(name: gps.name.downcase, ref_icon: gps.ref_icon.to_s, category: gps.category,
                   dowload_count: gps.dowload_count, author: gps.author, author_email: gps.author_email)
  Rating.create(rating: gps.rating, app_id: app.id)
else
  check_data_app(find_app, gps)
  Rating.create(rating: gps.rating, app_id: find_app.id)
end

puts 'end work'
exit
