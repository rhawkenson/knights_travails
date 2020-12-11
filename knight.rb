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
    @knight = Knight.new(start)
    @start = start
    @target = target
    get_children(start)
    children_to_nodes
  end 

  # Validates nodes so they can only be squares on the board
  def valid(move)
    validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
    validate.include?(move) ? true : false
  end 

  #Given a node, returns all legal children of said node
  def get_children(pos, current=@knight, visited=[])
    path = []
    x = pos[0]
    y = pos[1]
    move_math = [[x-2,y+1],[x-1,y+2],[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1]]
    move_math.each do |move|
      valid(move)? current.children << move : nil 
    end
    current.children
  end

  #turns children into nodes with their own parents and children
  def children_to_nodes(current=@knight, visited=[])  
    current.children.each do |child|
      return if visited.include?(@target)
      @child = Knight.new(child)
      @child.parent = current #====================uncomment later when you need access to parent data
      @child.children = get_children(@child.data, @child)
      visited << @child.data
      current = @child
      children_to_nodes(current, visited) unless visited.include?(@target)
      p visited
      #evaluate(visited, current)
    end
  end

  #visited and queue to look for the target
  def evaluate(visited, current)
    if visited.include?(@target)
      puts "#{@target} found in visited, #{visited}"
    end 
  end 

end 

def knight_moves(start, target)
  return "done" if start == target
  validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
  validate.include?(start) && validate.include?(target) ? Pathway.new(start, target) : "Invalid entry"
end 

knight_moves([3,3],[4,3])

