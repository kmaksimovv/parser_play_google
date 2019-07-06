require './lib/google_play_service'
require 'pg'

# test app 'https://play.google.com/store/apps/details?id=com.idamob.tinkoff.android'

link_app = ARGV

gps = GooglePlayService::ParsePageApp.new link_app.first

puts "name: #{gps.name},
      ref_icon: #{gps.ref_icon},
      category: #{gps.category},
      rating: #{gps.rating},
      dowloads: #{gps.dowloads},
      author: #{gps.author},
      author_email: #{gps.author_email}"
begin
  con = PG::Connection.new(host: 'localhost', dbname: 'apps', user: 'postgres', password: 'postgres')
  sql = "INSERT INTO app_info (name, ref_icon, category, rating, dowloads, author, author_email, created_at) VALUES('#{gps.name}', 
         '#{gps.ref_icon}', '#{gps.category}', '#{gps.rating}', '#{gps.dowloads}', '#{gps.author}', '#{gps.author_email}', 'now()')"
  con.exec(sql)
rescue PG::Error => e
  puts e.message
ensure
  con.close if con
end
