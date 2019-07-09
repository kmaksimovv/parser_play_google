require 'sequel'
require 'dotenv/load'

Sequel.connect(adapter: :"#{ENV['DB_ADAPTER']}", user: ENV['DB_USER'], password: ENV['DB_PASS'], host: ENV['DB_HOST'], database: ENV['DB_BASE'])
