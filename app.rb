require 'sinatra'
require 'sinatra/activerecord'

# Connect the database
db_options = {adapter: 'sqlite3', database: 'whiskey_app_test'}
ActiveRecord::Base.establish_connection(db_options)

# Set up the model
class Whiskey < ActiveRecord::Base
end

#route
get '/' do
    @whiskeys = Whiskey.order("created_at DESC");
    redirect '/new' if @whiskeys.empty?
    erb :index
end

get '/new' do
    erb :new_whiskey
end

post '/new' do
    @whiskey = Whiskeys.new(params[:whiskey])
    if @whiskey.save
        redirect "whiskey/#{@whiskey.id}"
    else
        erb :new_whiskey
    end
end

get '/whiskey/:id' do
    @whiskey = Whiskey.find_by_id(params[:id])
    erb :whiskey
end
