class Game
  def initialize(map)
    @current_room = 0
    @map = map
  end

  def move(key)
    next_room = 0
    result = @map[@current_room].directions.find {|room| room == key.downcase}
    if result == nil
      puts "There's no exit this way. You still cannot walk through walls, can you?"
      puts "Try again"
      play
    else
      case key.downcase
      when "n"
        next_room = @map.find {|room| room.name == @map[@current_room].door[:north]}
      when "s"
        next_room = @map.find {|room| room.name == @map[@current_room].door[:south]}
      when "e"
        next_room = @map.find {|room| room.name == @map[@current_room].door[:east]}
      when "w"
        next_room = @map.find {|room| room.name == @map[@current_room].door[:west]}
      end
      @current_room = @map.index(next_room)
      display_room(@map[@current_room])
    end
  end

  def display_room(room)
    puts "You're now in: #{room.name}" 
    puts "--------------------------------"
    puts room.description

    if room.name == "the FBI headquarters" || room.name == "the forest" || room.name == "Scully's house"
    play
    else
    finish_game
    end

  end

  def play
    puts "Now, which direction do you choose?"
    input = gets.chomp
    if input != "exit"
      move(input)
    else
      puts "Already leaving? Mulder and Scully are ashamed :("
      exit
    end
  end

  def start_game
    puts "************************************"
    puts "WELCOME TO THE X-FILES ADVENTURE"
    puts "Use your keyboard to move around (N = North, S = South, E = East, W = West)"
    puts "Press 'exit' to quit (don't you dare!)"
    puts "Which direction do you choose, my friend?"
    input = gets.chomp
    if input != "exit"
      move(input)
    else
      puts "Already leaving? Mulder and Scully are ashamed :("
      exit
    end
  end

  def finish_game
    puts "You've been a great agent but the FBI can't keep any relationship with you now. You're on your own."
    exit
  end
end


class Room
  attr_reader :name, :directions, :door, :description
  def initialize(name, directions, door, description)
    @name = name
    @directions = directions  
    @door = door          
    @description = description                    
  end
end


room1 = Room.new("the FBI headquarters",["s","e"], {north: nil, east: "the forest", south: "Scully's house", west: nil},"You're in a dusty office, full of boxes with cold cases waiting for a brave detective to solve them.Ohh! What time is it? You are late for the weekly meeting! RUN!")
room2 = Room.new("the forest",["s","w"], {north: nil, east: nil, south: "Jail", west: "the FBI headquarters"},"It's late and the sun has already gone. You're in the middle of the forest, waiting for some alien to appear. It's kinda creepy, better to go home.")
room3 = Room.new("Scully's house",["n","e"], {north: "the FBI headquarters", east: "Jail", south: nil, west: nil},"A glass of wine, nice background music...What does Scully want? Maybe you should go...")
room4 = Room.new("Jail",["n","w"], {north: nil, east: nil, south: nil, west: nil},"I don't know what you've done...but you probably deserve this. Good luck with your cellmates!")

map = [room1, room2, room3, room4]
insert_coin = Game.new(map)

insert_coin.start_game
