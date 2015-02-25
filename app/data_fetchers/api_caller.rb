require 'yelp'
require 'pry'
require 'json'
require 'open-uri'
require 'colorize'


class Apicaller

  attr_accessor :result

  @@config = []

  def initialize
    @result = ""
    configure
  end

  def configure
    if @@config.empty?
      Yelp.client.configure do |config|
      config.consumer_key = "kaRkVbBwBUiAjts8225KUQ"
      config.consumer_secret = "26rNl9lCaLhq79OJBim1Gc2Ns8w"
      config.token = "nK6ulC5Lq7s-Fr5PJThi9N8uKkbMnDi-"
      config.token_secret = "Ijp8e4zPjmtnOwri_gfLWb5Cl_8"
      @@config << "configured"
      end
    end
  end

  def resultprinter(results, keyword)
    if results.total > 0
      puts
      puts "Thank you for your patience. I found this on Yelp:"
      @result.businesses.each_with_index do |busines, index|
        puts "_"*busines.name.length + "___"
        puts "#{index+1}.#{busines.name}".colorize(:color => :green)
        puts "-"*busines.name.length + "---"
        puts "#{"Rating:".colorize(:color => :red)} #{busines.rating}"
        puts "#{busines.snippet_text}"
        puts
      end
    else

      print "\nno matches found for"
      puts " #{keyword}".colorize(:color => :red)
             # binding.pry

      ExampleCLI.new.run
       # binding.pry
    end
  end

  def yelpcall(keyword)
    zipcode = Location.new.zipcode
    @result = Yelp.client.search(zipcode, { term: "#{keyword}", radius_filter: '1000' })
  end

  def search(keyword)
    resultprinter(yelpcall(keyword), keyword)
  end

end


