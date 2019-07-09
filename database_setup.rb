require 'sequel'
require 'dotenv/load'

#create database
Sequel.connect(adapter: :"#{ENV['DB_ADAPTER']}", user: ENV['DB_USER'], password: ENV['DB_PASS'], host: ENV['DB_HOST']) {|db| db.execute "CREATE DATABASE #{ENV['DB_BASE']}"}

#create tables
DB = Sequel.connect(adapter: :"#{ENV['DB_ADAPTER']}", user: ENV['DB_USER'], password: ENV['DB_PASS'], host: ENV['DB_HOST'], database: ENV['DB_BASE'])

#migration
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
