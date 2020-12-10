class Board 
  def initialize(move)
    possible_moves(move)
  end 

  def possible_moves(move)
    axis = Array.new(8){|x| x+1}.repeated_combination(2).to_a
    puts axis.include?(move) ? true : false
  end 
end 

