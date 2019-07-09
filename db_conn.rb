host = 'localhost'
dbadapter = 'postgres'
dbname = 'google_play_app'
user = 'postgres'
passwd = 'postgres'

Sequel.connect(adapter: dbadapter, user: user, password: passwd, host: host, database: dbname)
