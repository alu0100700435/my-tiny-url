ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require 'bundler/setup'
require 'sinatra'
require 'data_mapper'


include Rack::Test::Methods

def app
	Sinatra::Application
end

require_relative '../app'

describe "My tiny url" do 

	before :all do
		@consult = Url.first_or_create(:user_id => '1', :url => "http://www.google.es", :short =>'google')
		@consult1 = Url.first(:user_id=> '1')

		@consult2 = Visit.create(:ip => '193.145.124.69', :url_id => '1')
		@consult3 = Visit.create(:ip => '121.0.0.1', :url_id => '1')

		@pag = "http://www.google.es"
		@pagerror = "http://www.facebook.com"

	end


	it "Deberia devolver que google esta dentro en la BBDD" do
		assert @pag, @consult1.url
	end

	it "Deberia devolver que el uid de la consulta es 0" do
		assert 0, @consult1.url
	end

	it "Deberia devolver una url erronea" do
		refute_equal @pagerror, @consult.url
	end

	it "Deberia devolver un error ya que ese campo no acepta URLs" do
		refute_equal @pag, @consult.short
	end
	
	it "Deberia devolver el pais desde el que se visita" do
		assert "Spain", @consult2.country
	end

	it "Deberia devolver la región desde la que se visita" do
		assert "Canary Islands", @consult2.region
	end

	it "No debera haber null en el pais" do
		refute_equal '', @consult3.country
	end

	it "No debera haber null en la región" do
		refute_equal '', @consult3.region
	end


end