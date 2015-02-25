require 'pry'
class CLI

  include HomeScreen

  attr_accessor :loc

  def initialize
    @loc = ""
  end

  def start
    HomeScreen.printhome
    call
  end

  def call
    puts "Welcome, what would you like to find?"
    run
  end

  def get_user_input
    puts
    print "loqal? > "
    gets.chomp.strip

  end

  def run
    puts "#{"Type whatever you'd like to find in your nearby area".colorize(:color => :green)}  "
    @loc = get_user_input
    if loc == "help"
      help
    elsif loc == "exit"
      getout
    else
      search(loc)
    end
    run
  end

  def moreinf(place, locnum)
    puts
    puts"______________________"
    puts "Type:".colorize(:color => :green)
    puts"'#{"1".colorize(:color => :red)}' to place a call"
    puts"'#{"2".colorize(:color => :red)}' to open reviews in browser"
    puts"'#{"3".colorize(:color => :red)}' to get directions"
    puts"'#{"4".colorize(:color => :red)}' to go back"
    puts"'#{"5".colorize(:color => :red)}' to do another search"
    puts"----------------------"
    input = get_user_input
    case input
    when "5"
      run

    when "2"
      place.reviews(locnum)
      moreinf(place, locnum)
    when "3"
      place.showdirections(locnum)
      moreinf(place, locnum)
    when "1"
      place.call(locnum)
      moreinf(place,locnum)
    when "4"
      # binding.pry
      search(loc)
    when "help"
      help
    when "exit"
      getout
    else
      puts
      puts "Wrong command: '#{input}' is not valid input."
      moreinf(place, locnum)
    end
  end

  def search(input)

    0.upto(2) do
      STDOUT.print "\rWe are looking for #{input} near you   "
      sleep 0.2
      STDOUT.print "\rWe are looking for #{input} near you.  "
      sleep 0.2
      STDOUT.print "\rWe are looking for #{input} near you.. "
      sleep 0.2
      STDOUT.print "\rWe are looking for #{input} near you..."
      sleep 0.2
    end
    # puts "We are looking for #{input} near you..."
    call = Apicaller.new
    call.search(input)
    puts
    puts
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts
    puts "Please enter a number to view a page in detail"
    puts"Or enter '#{"B".colorize(:color => :red)}' to do another search"
    puts "Example enter '#{"1".colorize(:color => :red)}' for #{"#{call.result.businesses[0].name}".colorize(:color => :green)} "
    locnum = get_user_input
    if locnum == "exit"
      getout
    elsif locnum.upcase == "B"
      run
    elsif locnum == "help"
      help
    elsif locnum.to_i != 0 && (locnum.to_i <= call.result.total && locnum.to_i <= 20)
      place = Resultsite.new(call.result)
      place.getlocationinfo(locnum)
      moreinf(place, locnum)
    else
      puts "#{locnum} not found, press enter to continue"
      gets.chomp
      search(input)
    end
  end

  def help
    puts "Type '#{"exit".colorize(:color => :green)}' to exit"
    puts "Type '#{"help".colorize(:color => :green)}' to view this menu again"
    puts "Type anything else to search for a location"
  end

  def getout
    puts "Are you sure you want to exit? (#{"Y".colorize(:color => :green)}/#{"N".colorize(:color => :red)})"
    input = get_user_input.upcase
    if input == "Y"
      STDOUT.print "\rExiting                "
      sleep 0.2
      STDOUT.print "\rExiting.               "
      sleep 0.2
      STDOUT.print "\rExiting..              "
      sleep 0.2
      STDOUT.print "\rExiting...             "
      sleep 0.2
      STDOUT.puts "\rThanks for using loqal?"
      sleep 1
      STDOUT.puts "\rHave a nice day!       "
      sleep 1
      exit
    end
  end
end

