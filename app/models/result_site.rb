require 'pry'
require 'launchy'
require 'open-uri'
require 'skype'
require 'colorize'

Skype.config :app_name => "davidsamsa"

class Resultsite

  attr_reader :example, :result

  def initialize(results)
    @result = results
  end

  def showdirections(locnum)
    index = locnum.to_i - 1
    coord = "#{result.region.center.latitude},#{result.region.center.longitude}"
    Launchy.open("https://www.google.com/maps/dir/#{coord}/#{result.businesses[index].location.coordinate.latitude},#{result.businesses[index].location.coordinate.longitude}/")
  end

  def getlocationinfo(locnum)
    index = locnum.to_i - 1
    busines = @result.businesses[index]
    business_string_counter = busines.name.length
    puts "X"*business_string_counter + "XXXXXX"
    busines.respond_to?("name") ? puts("X  #{busines.name.colorize(:color => :green)}  X") : puts("Name: na")
    puts "X"*business_string_counter + "XXXXXX"
    puts
    busines.respond_to?("rating") ? puts("#{"Rating:".colorize(:color => :red)} #{busines.rating}/5.0") : puts("Rating: na")
    busines.respond_to?("snippet_text") ? puts("#{"Review Snippet:".colorize(:color => :red)} #{busines.snippet_text}") : puts("Rating: na")
    busines.respond_to?("phone") ? puts("#{"Phone:".colorize(:color => :red)} #{busines.phone}") : puts("Phone: na")
    busines.location.respond_to?("display_address") ? puts(busines.location.display_address) : puts("Address: na")
  end

  def reviews(locnum)
    index = locnum.to_i - 1
    Launchy.open(result.businesses[index].url)
  end

  def call (locnum)
   index = locnum.to_i - 1
   puts "ARE YOU SURE YOU WANT TO MAKE A CALL? (#{"Y".colorize(:color => :green)}/#{"N".colorize(:color => :red)})"
   answer = gets.chomp.upcase
    if answer == "Y"
      result.businesses[index].respond_to?("phone") ? Skype.call("#{result.businesses[index].phone}") : puts("no phone")

    end
  end


end
