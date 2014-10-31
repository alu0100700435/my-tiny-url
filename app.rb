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
	@num = 0;
	@pais = Hash.new
	@dia = Hash.new
	@region = Hash.new 
	@mostrar = false
	haml :stadistic, :layout => :url
end


post '/estadisticas' do

	@pais = Hash.new
	@dia = Hash.new 
	@region = Hash.new 

	puts "inside post '/estadisticas': #{params}"
	uri = URI::parse(params[:estadistica])
	url = params[:estadistica]

	if url.include? "my-tiny-url-2.herokuapp.com"

		if uri.is_a? URI::HTTP or uri.is_a? URI::HTTPS then

			@mostrar = true
			short = params[:estadistica]
			short.slice!("http://my-tiny-url-2.herokuapp.com/")
			puts "short ===> #{short}"

			@url = Url.first(:short => short)
			id = @url.id
			@visit = Visit.all(:url_id => id)
			@num = @visit.count.to_i

			pais = @visit.contador_pais(id)	
			pais.each do |i|
				@pais[i.country] = i.count
			end

			dia = @visit.contador_fecha(id)
			dia.each do |i|
				@dia[i.date] = i.count
			end

			region = @visit.contador_region(id)
			region.each do |i|
				@region[i.region] = i.count
			end

			

		else
			logger.info "Error! <#{params[:estadistica]}> is not a valid URL"
				@error2=true;
		end

	else
		@error_no = true
	end
	
	
	haml :stadistic, :layout => :url

end

get '/:short' do

end