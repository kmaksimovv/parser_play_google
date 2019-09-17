require './db_conn'
require 'sequel'
require 'sinatra'
require 'sinatra/contrib'

Dir[File.expand_path('lib/*.rb', __dir__)].each do |file|
  require file
end


namespace '/api/v1' do
  before do
    content_type 'application/json'
  end
  
  get '/apps' do
    apps = App.all
    MultiJson.dump(App.all.map { |s| s.to_api })
  end
end
