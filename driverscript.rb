=begin
1. Put together a script that creates a game board and a knight.
  class Board
    -stores all the possible moves in an array 
  class Knight
    -knight can check that the move is included in the possible moves array on Board
    -knight's position given in x,y values
    -knight's next moves are it's children (up to 8 total)
    -to get next move, perform arithmatic on the x,y for each child move
    

2. Treat all possible moves the knight could make as children in a tree. 
Don’t allow any moves to go off the board.
    -use the Board class to validate the potential moves 

3. Decide which search algorithm is best to use for this case. 
Hint: one of them could be a potentially infinite series.
    -include a counter to return the number of moves necessary 

4. Use the chosen search algorithm to find the shortest path between the 
starting square (or node) and the ending square. Output what that full path 
looks like, e.g.:

 > knight_moves([3,3],[4,3])
  => You made it in 3 moves!  Here's your path:
    [3,3]
    [4,5]
    [2,4]
    [4,3]
=end

# ==== Code for children of any given node ====
def valid(move)
  validate = [1,2,3,4,5,6,7,8].repeated_permutation(2).to_a
  validate.include?(move) ? true : false
  
end

def moves(start)
  children = []
  x = start[0]
  y = start[1]
  move_math = [[x-2,y+1],[x-1,y+2],[x+1,y+2],[x+2,y+1],[x+2,y-1],[x+1,y-2],[x-1,y-2],[x-2,y-1]]

  move_math.each do |move|
    valid(move)? children << move : nil  
  end
 children
end 