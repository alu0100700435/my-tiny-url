source "http://rubygems.org"
ruby "2.0.0"

gem 'sinatra'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pry' 
gem 'erubis'
gem 'data_mapper'
gem 'sinatra-contrib'
gem 'haml'

gem 'chartkick'
gem 'groupdate'
gem 'dm-core'
gem 'dm-timestamps'
gem 'dm-types' 
gem 'rest-client'
gem 'xml-simple'


group :production do
	gem "pg"
	gem "dm-postgres-adapter"
end

group :development do
	gem "sqlite3"
	gem "dm-sqlite-adapter"
end

group :test do
	gem "sqlite3"
	gem "dm-sqlite-adapter"
    gem "rack-test"
    gem "rake"
end