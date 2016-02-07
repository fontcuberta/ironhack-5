require 'pry'

module Vertical
  def check_v
    @start[1] == @destination[1]
  end
end

module Horizontal
  def check_h 
    @start[0] == @destination[0]
  end
end

module Diagonal
  def check_d 
    (@start[0] - @destination[0]).abs == (@start[1] - @destination[1]).abs
  end
end

module Steps
  def one_step
    if Vertical
      (@destination[0] - @start[0]).abs == 1
    elsif Horizontal
      (@destination[1] - @start[1]).abs == 1      
    else #Diagonal
      (@destination[0] - @start[0].abs && (@destination[1] - @origin[1]).abs == 1)
    end
  end

  def two_steps
    (@destination[0] - @start[0]).abs == 2 || (@destination[1] - @start[1]).abs == 2
  end
end

module Forward
  def check_f
    if @color == "w"
      @destination[0] > @start[0]
    elsif @color == "b"
      @destination[0] < @start[0]
    end
  end
end

module GetContent
  def get_content(filename)
    file = File.open(filename,"r")
    input = file.read.split(/\n/)
    file.close
    input
  end
end

#----------------------------
#---------PIECES-------------
#----------------------------

class Piece
  attr_reader :start, :destination, :piece, :color
  def initialize (start, destination, piece, color) 
    @start = start 
    @destination = destination
    @piece = piece
    @color = color
  end
end

class Rook < Piece
  include Vertical
  include Horizontal

  def check_move
    check_v || check_h
  end
end

class Bishop < Piece
  include Diagonal

  def check_move
    check_d
  end
end

class Queen < Piece
  include Vertical
  include Horizontal
  include Diagonal

  def check_move
    check_v || check_h || check_d 
  end
end

class Pawn < Piece
  def initialize
    super
    @firstMove = true
  end

  def check_move
    if @firstMove
      check_v && check_f && two_steps || one_step
    else
      check_v && check_f && one_step 
    end
  end
end

class King < Piece
  include Steps

  def check_move 
    one_step  
  end
end

class Knight < Piece 
  include Vertical
  include Horizontal
  include Vertical
  include Steps

  def check_move
    !check_h && !check_v && !check_d && two_steps    
  end
end

#----------------------------
#----------BOARD-------------
#----------------------------

class Board
include GetContent
  attr_accessor :board, :pieces, :positions

  def initialize(boardfile)
    @board = create_board(boardfile)
    @pieces = { bP: Pawn, bR: Rook, bN: Knight, bB: Bishop, bQ: Queen, bK: King,
          wP: Pawn, wR: Rook, wN: Knight, wB: Bishop, wQ: Queen, wK: King
        }
    @positions = decode_positions
  end

  def create_board(boardfile)
    input = get_content(boardfile)
    input.map! { |box| box.split(" ") }

    input.each do |i|
      i.map! { |piece| piece.to_sym }
    end

    input
  end

  def decode_positions
    letters = "abcdefgh"
    numbers = "12345678"
    positions = []
    x_coords = "12345678"
    y_coords = "12345678"
    xy_coords = []

    hash_of_positions = { }

    numbers.split(//).each { |n| letters.split(//).each { |l| positions.push((l + n).to_sym) } }

    x_coords.split(//).each { |x| y_coords.split(//).each { |y| xy_coords.push([x.to_i , y.to_i]) } }

    positions.each_with_index {|p, i| hash_of_positions[p] = xy_coords[i] }
    
    hash_of_positions #hash with the equivalence of all the posible positions in the board 
  end
end


class Movement
  include GetContent
  attr_reader :moves

  def initialize(movesfile)
    @moves = get_movements(movesfile)
  end

  def get_movements(movesfile)
    movements = get_content(movesfile)
    movements.map! {|coord| coord.split(" ")}

    movements.each do |i|
      i.map! {|coordinate| coordinate.to_sym}
    end
    movements
  end 

  def validate_movements(board, moves)
    @moves.each do |i|
      @start = i[0]
      @destination = i[1]

      # if @piece == false
      #   false
      # else
      #   case @piece[:name]
      #   when 'r'
      #     Rook.new(@start, @destination, piece[:color]).check_move
      #   when 'n'
      #     Knight.new(@start, @destination, piece[:color]).check_move
      #   when 'b'
      #     Bishop.new(@start, @destination, piece[:color]).check_move
      #   when 'q'
      #     Queen.new(@start, @destination, piece[:color]).check_move
      #   when 'k'
      #     King.new(@start, @destination, piece[:color]).check_move
      #   when 'p'
      #     Pawn.new(@start, @destination, piece[:color]).check_move
      #     binding.pry
      #   end
      # end
    end

  end
end





chezzGame = Board.new("board.txt")
trial = Movement.new("moves.txt")
trial.validate_movements("board.txt", "moves.txt")
#chezzGame.check_moves(Moves.new("moves.txt"))






