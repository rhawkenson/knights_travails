#===== Psuedocode =====
# 1. knight_moves(start, target) is called to run the code
# 2. Create a new instance class for the starting point
# 3. Recursively create new instances when for each possible move from the start
# 4. If the target matching the starting point, end the search
# 5. Count the number of interations needed to reach the starting point 
# 6. Return the moves made to reach the target and the number of moves taken


class Node
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end 

class KnightsTravails
  def children
    knight = Node.new(start[0], start[1])
    childen = Array.new
    children << [knight.y, knight.y]

  end 

end

def knight_moves(start, target)
  start = KnightsTravails.new(start, target)
  puts "You made it in #{moves} moves! Here is your path:"
end 


knight_moves([3,3][4,3])