require_relative 'board'

class Knight 
  attr_accessor :data, :children, :parent
  def initialize(data)
    @data = data
    @parent = nil
    @children = Array.new
  end 
end 

class Pathway
  attr_accessor :knight 
  attr_reader :target, :start
  def initialize(start, target)
    @start = start
    @target = target
    @knight = Knight.new(@start)
    visited = []
    visited << @knight
    get_children(@knight.data, @knight)
    make_nodes(@knight, visited)
  end 

  # Validates nodes so they can only be squares on the board
  def valid(move)
    validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
    validate.include?(move) ? true : false
  end 

  #Given a node, returns all legal children of said node
  def get_children(pos, current)
    x = pos[0]
    y = pos[1]
    move_math = [[x-2,y+1],[x-1,y+2],[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1]]
    move_math.each do |move|
      valid(move)? current.children << move : nil 
    end
  end


#turns children into nodes with their own parents and children
  def make_nodes(current=@knight, visited=[], queue=[]) 
    
    return path(current, queue, visited) if current.children.include?(@target)
    current.children.each do |child|
      queue << child
    end 

    queue.each do |node|
      child = Knight.new(node)
      child.parent = current 
      get_children(child.data, child)
      visited << child
    end
    visited.shift
    make_nodes(visited[0], visited)
  end 


  def path(current, queue, visited)
    steps = Array.new
    steps << @target
    steps << current.data
    
    until current.parent.nil? do 
      steps << current.parent.data
      current = current.parent
    end
    p "You made it in #{steps.length-1} steps!"
    p steps.reverse
    count_steps(current)
  end 

  def count_steps(current, counter=0)
    until current.parent.nil? do 
      counter += 1
      current = current.parent 
    end
  end 

# END OF CLASS 
end 

def knight_moves(start, target)
  return "done" if start == target
  validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
  validate.include?(start) && validate.include?(target) ? Pathway.new(start, target) : "Invalid entry"
end 

knight_moves([3,3],[7,3])