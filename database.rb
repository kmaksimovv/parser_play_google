require 'pg'

# your`s settings
pg_host = 'localhost'
pg_user = 'postgres'
pg_passwd = 'postgres'


begin
  con = PG::Connection.new(host: pg_host, user: pg_user, password: pg_passwd)
  puts 'Successfully created connection to database'

  con.exec('CREATE DATABASE apps')
  puts 'Successfully created database'

  conn = PG::Connection.new(host: pg_host, dbname: 'apps', user: pg_user, password: pg_passwd)
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
