require_relative 'main.rb'
class Board
  def valid_moves
    values = [1,2,3,4,5,6,7,8]
    valid_moves = values.repeated_combination(2).to_a
    return valid_moves 
  end 

  def check_validity(options)
    options.keep_if {|coordinates| valid_moves.include?(coordinates)}
    return options
  end 

  def knight(start)
    options = Array.new
    option_math = [[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1]]
    option_math.each do |x,y|
      options << [start[0] + x, start[1] + y] 
    end 
    check_validity(options)
  end 
end 


sample = Board.new

#knight_moves([3,3],[4,3])