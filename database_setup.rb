require 'rubygems'
require 'sequel'

host = 'localhost'
dbadapter = 'postgres'
dbname = 'google_play_app'
user = 'postgres'
passwd = 'postgres'

#create database
Sequel.connect(adapter: :"#{dbadapter}", user: "#{user}", password: "#{passwd}", host: "#{host}") {|db| db.execute "CREATE DATABASE #{dbname}"}

#create tables
DB = Sequel.connect(adapter: :"#{dbadapter}", user: "#{user}", password: "#{passwd}", host: "#{host}", database: "#{dbname}")

DB.create_table :apps do
  primary_key :id
  String :name, unique: true, null: false
  String :ref_icon
  String :category
  String :dowload_count
  String :author
  String :author_email
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
end

DB.create_table :ratings do
  primary_key :id
  String :rating, null: false
  foreign_key :app_id, :apps, null: false
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP

  index :app_id
end

puts 'Successfully created database and tables'
puts '########################################'
