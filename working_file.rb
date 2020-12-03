#===== Psuedocode =====
# 1. knight_moves(@start, target) is called to run the code
# 2. Create a new instance class for the @starting point
# 3. Recursively create new instances when for each possible move from the @start
#      
# 4. If the target matching the @starting point, end the search
# 5. Count the number of interations needed to reach the @starting point 
# 6. Return the moves made to reach the target and the number of moves taken


class Node
  attr_accessor :start, :child1, :child2, :child3, :child4, :child5, :child6, :child7, :child8
  def initialize(start)
    @start = start
    @child1 = nil
    @child2 = nil
    @child3 = nil
    @child4 = nil
    @child5 = nil
    @child6 = nil
    @child7 = nil
    @child8 = nil
  end
end 

class KnightsTravails
  def initialize(start, target)
    @start = start
    @target = target
    @knight = Node.new(@start)
    build_board
  end 

  def build_board
    return if preorder.include?(@target)
    child1_move = [@start[0]-2, @start[1]+1] 
    child2_move = [@start[0]-1, @start[1]+2]
    child3_move = [@start[0]+1, @start[1]+2]
    child4_move = [@start[0]+2, @start[1]+1]
    child5_move = [@start[0]+2, @start[1]-1]
    child6_move = [@start[0]+1, @start[1]-2]
    child7_move = [@start[0]-1, @start[1]-2]
    child8_move = [@start[0]-2, @start[1]-1]

    @knight.child1 = KnightsTravails.new(child1_move, @target) if valid(child1_move)
    @knight.child2 = KnightsTravails.new(child2_move, @target) if valid(child2_move)
    @knight.child3 = KnightsTravails.new(child3_move, @target) if valid(child3_move)
    @knight.child4 = KnightsTravails.new(child4_move, @target) if valid(child4_move)
    @knight.child5 = KnightsTravails.new(child5_move, @target) if valid(child5_move)
    @knight.child6 = KnightsTravails.new(child6_move, @target) if valid(child6_move)
    @knight.child7 = KnightsTravails.new(child7_move, @target) if valid(child7_move)
    @knight.child8 = KnightsTravails.new(child8_move, @target) if valid(child8_move)
  end 

  #preorder sort 
  def preorder(current = @knight, visited = [])
    return visited if current.nil?
    visited << current.start
    preorder(current.child1, visited)
    preorder(current.child2, visited)
    preorder(current.child3, visited)
    preorder(current.child4, visited)
    preorder(current.child5, visited)
    preorder(current.child6, visited)
    preorder(current.child7, visited)
    preorder(current.child8, visited)
  end

  def valid(arr)
    if arr[0] > 0 && arr[0] <= 8 
      if arr[1] > 0 && arr[1] <= 8
        return true 
      end 
    end 
  end 


end

def knight_moves(start, target)
  KnightsTravails.new(start, target)
end 


knight_moves([3,3],[4,3])