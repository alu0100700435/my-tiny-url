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

		def set_country			
		    xml = RestClient.get "http://ip-api.com/xml/#{self.ip}"  
		    coun = XmlSimple.xml_in(xml.to_s, { 'ForceArray' => false })['country'].to_s
		    if coun == nil || (coun == "{}") 
				coun = "Desconocida"
			end
		    self.country = coun
		  	self.save
		end


		def set_region
			xml = RestClient.get "http://ip-api.com/xml/#{self.ip}"
			reg = XmlSimple.xml_in(xml.to_s, { 'ForceArray' => false })['regionName'].to_s
			puts "region ---> #{reg}"

			if (reg == nil) || (reg == "{}") 
				reg = "Desconocida"
			end
			puts "region ---> #{reg}"
			self.region = reg
			self.save
		end



		def self.contador_fecha(id)
			repository(:default).adapter.select("SELECT date(created_at) AS date, count(*) AS count FROM visits WHERE url_id = '#{id}' GROUP BY date(created_at)")
		end

		def self.contador_pais(id)
			repository(:default).adapter.select("SELECT country, count(*) as count FROM visits where url_id= '#{id}' group by country")
		end

		def self.contador_region(id)
			repository(:default).adapter.select("SELECT region, count(*) as count FROM visits where url_id= '#{id}' group by region")
		end
		
end