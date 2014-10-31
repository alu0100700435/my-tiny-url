require 'dm-core'
require 'dm-migrations'
require 'restclient'
require 'xmlsimple'
require 'dm-timestamps'

class User
	include DataMapper::Resource
		property :id, Serial
		property :uid, String 
		property :name, String
		property :email, String
		property :imagen, Text
		property :created_at, DateTime	

		has n, :url		
end


class Url
	include DataMapper::Resource
		property :id, Serial
		property :url, Text
		property :short, Text

		belongs_to :user

		has n, :visit
end

class Visit
	include DataMapper::Resource
		property  :id,          Serial
		property  :ip,          IPAddress
		property  :country,     String
		property  :region,      String	
		property  :created_at,  DateTime

		belongs_to :url
		
end