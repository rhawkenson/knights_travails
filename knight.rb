require_relative 'board'

class Knight 
  attr_accessor :data, :children
  def initialize(data)
    @data = data
    @children = Array.new
  end 
end 

class PlayGame
  attr_accessor :knight 
  attr_reader :target

  def initialize(start, target)
    return game_over if start == target
    @knight = Knight.new(start)
    @target = target
    moves(start)
  end 

  def valid(move)
    validate = Array.new(8){|x| x+1}.repeated_combination(2).to_a
    validate.include?(move) ? true : false
  end 

  def moves(start)
    x = start[0]
    y = start[1]
    move_math = [[x-2,y+1],[x-1,y+2],[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1]]
    
    #Evaluate if the move is legal
    move_math.each do |move|
      valid(move)? @knight.children << move : nil  
    end
    #if the target has been found, end the cycle. Otherwise, go to #branch to become a node
    @knight.children.include?(@target) ? game_over : branch(@knight.children)
  end 

  def branch(children)
    
  end 

  def game_over
    puts "\n\n\n\nGAME OVER\n\n\n\n\n"
  end 
end 

def knight_moves(start, target)
  return "done" if start == target
  validate = Array.new(8){|x| x+1}.repeated_combination(2).to_a
  validate.include?(start) && validate.include?(target) ? PlayGame.new(start, target) : "Invalid entry"
end 

knight_moves([3,3],[1,4])

