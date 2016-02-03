class Home
  attr_reader(:name, :city, :capacity, :price)

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end
end

class Home_manager
  attr_reader(:homes)

  def initialize
    @homes = []
  end

  def add_home home
    @homes << home
  end
  
  def display_homes(array)
   array.each do |home|
    puts " "
    puts "#{home.name}'s place in #{home.city}"
    puts "Price: #{home.price} a night"
    puts "Capacity: #{home.capacity} pax."
   end
  end

  def price_sorted
    @homes.sort{|home1, home2| home2.price <=> home1.price} 
  end

  def capacity_sorted
    @homes.sort{|home1, home2| home2.capacity <=> home1.capacity} 
  end


  def show_sorted_homes
      
    input = ""

    unless input.include?(("price") || ("capacity"))
      puts "Do you want to sort by price or by capacity?"
      input = gets.chomp.downcase
    end

    if input == "price"
      puts "***HOMES BY PRICE***"
     display_homes(price_sorted())
    elsif input == "capacity"
      puts "***HOMES BY CAPACITY***"
     display_homes(capacity_sorted())
    end
  end


  def homes_filtered(city)   
    @homes.select{|home| home.city == @answer}
  end


  def show_filtered_homes

    @answer = ""
    puts "Choose a city between Boston, Tucson, Monterey and Austin"
    @answer = gets.chomp.capitalize

    if @answer == "Boston"
      puts "***HOMES IN BOSTON***"
      display_homes(homes_filtered("boston"))
    elsif @answer == "Tucson"
      puts "***HOMES IN TUCSON***"
      display_homes(homes_filtered("tucson"))
    elsif @answer == "Monterey"
      puts "***HOMES IN MONTEREY***"
      display_homes(homes_filtered("monterey"))
    elsif @answer == "Austin"
      puts "***HOMES IN AUSTIN***"
      display_homes(homes_filtered("austin"))
    end
  end


  def average_price
    total_price = @homes.reduce(0.0) do |sum, home|
      sum + home.price
    end
    puts "The average price of all these homes is: "
    puts total_price / @homes.length
  end



end

hm = Home_manager.new
hm.add_home(Home.new("Nizar", "Boston", 2, 42))
hm.add_home(Home.new("Fernando", "Tucson", 5, 47))
hm.add_home(Home.new("Josh", "Monterey", 3, 41))
hm.add_home(Home.new("Gonzalo", "Boston", 2, 45))
hm.add_home(Home.new("Ariel", "Austin", 4, 49))


hm.display_homes(hm.homes)
hm.show_sorted_homes
hm.show_filtered_homes
hm.average_price







    
