require 'pry'

class Location

  attr_reader :urlhash

  def initialize
      @urlhash = JSON.load(open("http://ipinfo.io/json"))
  end

  def coordinates
     @urlhash["loc"]
  end

  def zipcode
    @urlhash["postal"]
  end

end
