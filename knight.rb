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
  def get_children(pos, current=@knight)
    x = pos[0]
    y = pos[1]
    move_math = [[x-2,y+1],[x-1,y+2],[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1]]
    move_math.each do |move|
      valid(move)? current.children << move : nil 
    end
    current.children
  end

  
=begin
  #children_to_nodes steps: 
    1. iterate over the current piece, if no current is passed, use @knight (root)
    2. if "visited" contains the target, end the iteration
    3. turn the variable being iterated into a node
    4. set the parent and children of the current iteration 
    5. visited concatenates all the children of the current iteration
    6. current is reset to the current iteration #### Possibly unnecessary 
    7. queue takes in all unique children 
    8. queue is cleaned up and passed into #level to get the next level of children (grandchildren of root)
=end


#turns children into nodes with their own parents and children
  def children_to_nodes(current=@knight, visited=[], queue=[])  
    if visited.include?(@target)
      path(current)

    else
      current.children.each do |child|
        #return "found" if visited.include?(@target)
        @child = Knight.new(child)
        @child.parent = @knight #====================uncomment later when you need access to parent data
        @child.children = get_children(@child.data, @child)
        visited << @child.data unless visited.include?(@child.data)
        
        @child.children.each do |child|
          queue << child unless queue.include?(child)
        end 
      end
      level(visited, queue)
    end 
  end

=begin
  #level breakdown:
    1. the queue items are made into nodes
    2. pass the node into #get_children and #children_to_nodes
    3. visited takes in the first item from queue
    4. the first item in queue is deleted
=end


  #visited and queue to look for the target
  def level(visited, queue=[])
    current = Knight.new(queue[0])
    visited << queue[0] unless visited.include?(queue[0])
    queue.shift
    
    get_children(current.data, current)
    children_to_nodes(current, visited, queue)
  end

  def path(current)
    p "YOU DID IT! current: #{current}, #{current.data} target: #{target}"
  end 


end 

def knight_moves(start, target)
  return "done" if start == target
  validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
  validate.include?(start) && validate.include?(target) ? Pathway.new(start, target) : "Invalid entry"
end 

knight_moves([3,3],[4,3])

