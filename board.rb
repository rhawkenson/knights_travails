class Board 
  def initialize
    @board = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
    possible_moves(move)
  end 

  def possible_moves(move)
    puts @board.include?(move) ? true : false
  end 
end 

