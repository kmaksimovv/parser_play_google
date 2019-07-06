require 'pg'

begin
  con = PG::Connection.new(host: 'localhost', user: 'postgres', password: 'postgres')
  puts 'Successfully created connection to database'
  con.exec('CREATE DATABASE apps')
  puts 'Successfully created database'
  conn = PG::Connection.new(host: 'localhost', dbname: 'apps', user: 'postgres', password: 'postgres')
  puts 'Successfully connected database apps'
  conn.exec("CREATE TABLE app_info(id SERIAL, name VARCHAR, ref_icon VARCHAR, category VARCHAR, 
             rating VARCHAR,dowloads VARCHAR, author VARCHAR, author_email VARCHAR, created_at TIMESTAMPTZ)")
  puts 'Successfully created table apps_info'
rescue PG::Error => e
  puts e.message
ensure
  con.close if con
  conn.close if conn
end
