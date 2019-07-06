require './lib/google_play_service'
require 'pg'

pg_host = 'localhost'
pg_user = 'postgres'
pg_passwd = 'postgres'

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
  con = PG::Connection.new(host: pg_host, dbname: 'apps', user: pg_user, password: pg_passwd)
  sql = "INSERT INTO app_info (name, ref_icon, category, rating, dowloads, author, author_email, created_at) VALUES('#{gps.name}',
         '#{gps.ref_icon}', '#{gps.category}', '#{gps.rating}', '#{gps.dowloads}', '#{gps.author}', '#{gps.author_email}', 'now()')"
  con.exec(sql)
  puts 'Successfully created info for app'
rescue PG::Error => e
  puts e.message
ensure
  con.close if con
end
