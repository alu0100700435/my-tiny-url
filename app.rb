#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'omniauth-oauth2'
require 'omniauth-github'
require 'omniauth-google-oauth2'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'uri'
require 'data_mapper'
require 'erubis'
require 'pp'
require 'haml'
require 'chartkick'
require 'groupdate'
require 'dm-core'
require 'dm-timestamps'
require 'dm-types' 
require 'restclient'
require 'xmlsimple'

use Rack::Session::Pool, :expire_after => 2592000
set :session_secret, '*&(^#234a)'


use Rack::Session::Pool, :expire_after => 2592000
set :session_secret, '*&(^#234a)'


configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/my_shortened_urls.db")
end
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end


DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!


use OmniAuth::Builder do
	config = YAML.load_file 'config/config.yml'
  	provider :github, config['identifier'], config['secret']
  	provider :google_oauth2, config['identifier_g'], config['secret_g']
  	provider :facebook, config['identifier_f'], config['secret_f']
  	provider :twitter, config['identifier_t'], config['secret_t'] 
end



helpers do
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

get '/auth/:name/callback' do
	session.clear
	@auth = request.env["omniauth.auth"]
	@user = User.first_or_create({ :uid => @auth["uid"]}, {
	:uid => @auth["uid"],
	:name => @auth["info"]["name"],
	:email => @auth["info"]["email"],
	:imagen => @auth["info"]["image"],
	:created_at => Time.now	})
	
	session[:user_id] = @user.id
	redirect '/'
end

get '/auth/failure' do
	redirect '/'
end

get '/sign_github' do 
	redirect '/auth/github'
	
end

get '/sign_google/?' do
	redirect '/auth/google_oauth2'
	
end

get '/sign_facebook/?' do 
	redirect '/auth/facebook'
	
end

get '/sign_twitter/?' do 
	redirect '/auth/twitter'
	
end


get "/sign_out" do
	session.clear
	redirect '/'
end


post '/' do


end


get '/estadisticas' do

end


post '/estadisticas' do

end

get '/:short' do

end