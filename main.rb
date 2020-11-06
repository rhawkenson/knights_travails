class Node
  attr_accessor :position, :top, :bottom, :left, :right
  def initialize(position)
    @position = position 
    @top = nil
    @bottom = nil
    @left = nil 
    @right = nil 
  end 
end 

class Gameboard 
  attr_accessor :current
  def initialize
    arr = Array.new(8){|index| index+1 }
    @current = grid_maker(arr)
  end 

  def grid_maker(arr)
    grid = arr.repeated_combination(2).to_a
    board_connections(grid)
  end 

  def board_connections(arr, counter = 0)
    node = Node.new(arr[counter])
    node.right = arr[counter+1]
    return node if counter >= arr.length
    p node
    counter += 1

    board_connections(arr, counter)
     node

    

  end 

end 

knight = Gameboard.new
knight 