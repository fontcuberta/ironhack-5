require 'pry'

class ShopppingCart
  def initialize(season, weekday)
    @units = {}
    @pricelist_by_season = {
      spring: {apples: 10,oranges: 5, grapes: 15, bananas: 20, watermelon: 50},
      summer: {apples: 10,oranges: 2, grapes: 15, bananas: 20, watermelon: 50},
      autumn: {apples: 15,oranges: 5, grapes: 15, bananas: 20, watermelon: 50},
      winter: {apples: 12,oranges: 5, grapes: 15, bananas: 21, watermelon: 50}
    }
    @items_discount = {}
    @season = season
    @weekday = weekday
    #@weekday = Time.now.strftime("%A") Podemos activar @weekday y eliminar la segunda variable del método initialize para no "forzar" el día de la semana
  end

  def add_fruit(item)
    if @units[item]
      @units[item] += 1
    else
      @units[item] = 1
    end
  end

  def show_cart
    puts "This is your shopping cart:"
    @units.each do |fruit, quantity| 
    puts "#{quantity} #{fruit}: #{@pricelist_by_season[@season][fruit]*quantity}$"
   end
   puts "The total cost of your purchase (including discounts and seasonal pricing) is #{@total_cost}$"
  end

  def calculate_cost
    self.calculate_discount

    @total_cost = 0
    @units.each do |fruit, quantity|
      if @weekday == "Sunday" && fruit == :watermelon 
        @total_cost += (@pricelist_by_season[@season][fruit]*2)*(quantity - (@items_discount[fruit] || 0))
      else
      @total_cost += @pricelist_by_season[@season][fruit]*(quantity - (@items_discount[fruit] || 0))
      end
    end
    show_cart
  end

  def calculate_discount
    @units.each do |fruit, quantity|
      #Buy 2 apples and pay 1
      if fruit == :apples && quantity >=2
        @items_discount[fruit] = quantity/2
      #Buy 3 oranges and pay 2
      elsif fruit == :oranges && quantity >=3
        @items_discount[fruit] = quantity/3
      #Buy 4 grapes and get a free banana
      elsif fruit == :grapes && quantity >=4
        puts "Thank you for your shopping! You've bought #{@units[fruit]} grapes, would you like #{quantity/4} banana for free? (YES = y, NO = n)"
        input = ""
        input = gets.chomp
        if input.downcase == "y"
          @units[:bananas] == nil ? @units[:bananas] == 1 : @units[:bananas] +=1 
        else
          puts "Ok, have a nice day then!"
        end
      end
    end
  end


end

cart = ShopppingCart.new(:winter, "Sunday")

cart.add_fruit(:apples)
cart.add_fruit(:apples)
cart.add_fruit(:apples)
cart.add_fruit(:apples)
cart.add_fruit(:apples)
cart.add_fruit(:oranges)
cart.add_fruit(:oranges)
cart.add_fruit(:oranges)
cart.add_fruit(:grapes)
cart.add_fruit(:grapes)
cart.add_fruit(:grapes)
cart.add_fruit(:grapes)
cart.add_fruit(:watermelon)


cart.calculate_cost


