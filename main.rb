#=====Psuedocode=====
# 1. Create UI with knight and gameboard 
# 2. Possible moves are node children in a tree 
#     - The user chooses the starting point and end point
# 3. Use a search algorithm to traverse the tree 
# 4. Use the search algorithm to find the shortest path to the ending point  

#=====Guide to node names=====
# The nodes 1-8 represent the possible outcomes move for the knight
# The possible nodes start on the top left and work clockwise around the knight 
# In the board below, [2,5] would be possibility one, [3,6] would be possibility two, and so on 
# "8___|___|___|___|___|___|___|___|"
# "7___|___|___|___|___|___|___|___|"
# "6___|___|_*_|___|_*_|___|___|___|"
# "5___|_*_|___|___|___|_*_|___|___|"
# "4___|___|___|_X_|___|___|___|___|"
# "3___|_*_|___|___|___|_*_|___|___|"
# "2___|___|_*_|___|_*_|___|___|___|"
# "1___|___|___|___|___|___|___|___|"
# "  1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"



class Node
  attr_accessor :position, :one, :two, :three, :four, :five, :six, :seven, :eight
  def initialize(position)
    @position = position 
    #See header comments "guide to node names"
    @one = nil
    @two = nil
    @three = nil
    @four = nil
    @five = nil
    @six = nil
    @seven = nil
    @eight = nil 
  end 
end 

class Gameboard 
  attr_accessor :current
  def initialize
    start_screen
  end 

  def start_screen 
    puts "\n\n\nWelcome to Knight's Travails! You will first be prompted to select a starting point, 
    then an ending point. Your starting and ending points need to be entered as you would read a graph: 
    x, then y. The computer will generate the most efficient path for you, showing the best path to follow 
    and number of moves required. If you need a demonstration, please select 2 below. 
    Otherwise, happy trails! \n\n"
    
    game_board
    start_options
  end 

  def game_board
    puts "8___|___|___|___|___|___|___|___|"
    puts "7___|___|___|___|___|___|___|___|"
    puts "6___|___|___|___|___|___|___|___|"
    puts "5___|___|___|___|___|___|___|___|"
    puts "4___|___|___|___|___|___|___|___|"
    puts "3___|___|___|___|___|___|___|___|"
    puts "2___|___|___|___|___|___|___|___|"
    puts "1___|___|___|___|___|___|___|___|"
    puts "  1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"
  end 

  def start_options
    puts "\nWhat would you like to do?"
    puts "[1] Start new game \n[2] See demonstration\n[3] Exit\n\n"
    choice = gets.chomp.to_i
    if choice > 3 || choice < 1
      "Please make a valid selection. Enter 1, 2, or 3"
    elsif choice == 1 
      PlayGame.new
    elsif choice == 2
    
    puts "********START HERE*******"
    puts "First you will choose your starting point. Let's select [4,4]. You knight is shown on [4,4] with an 'X'.
    Next, you will choose your desired ending point. For demonstrative purposes, we will choose [3,3].
    From your starting point, your knight can move in an L-shape. That means they can move 2 blocks in any
    direction, and then one block in a different direction. The knight cannot travel diagonally. 
    From [4,4], the possible outcomes for the next move are marked with '*'.
    
    \n\n"
    puts "8___|___|___|___|___|___|___|___|"
    puts "7___|___|___|___|___|___|___|___|"
    puts "6___|___|_*_|___|_*_|___|___|___|"
    puts "5___|_*_|___|___|___|_*_|___|___|"
    puts "4___|___|___|_X_|___|___|___|___|"
    puts "3___|_*_|___|___|___|_*_|___|___|"
    puts "2___|___|_*_|___|_*_|___|___|___|"
    puts "1___|___|___|___|___|___|___|___|"
    puts "  1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"

    puts "\n\nIf we travel to [2,5] next, we can get
    to our target of [3,3] in 2 moves. [3,3] is marked with 'O'.
    \n\n"
    puts "8___|___|___|___|___|___|___|___|"
    puts "7_*_|___|_*_|___|___|___|___|___|"
    puts "6___|___|___|_*_|___|___|___|___|"
    puts "5___|_X_|___|___|___|___|___|___|"
    puts "4___|___|___|_*_|___|___|___|___|"
    puts "3_*_|___|_O_|___|___|___|___|___|"
    puts "2___|___|___|___|___|___|___|___|"
    puts "1___|___|___|___|___|___|___|___|"
    puts "  1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"

    puts "\n\n
    When you enter your starting and ending point, the computer will tell you the most 
    efficient route and count the least possible moves for you. Let's play!!\n\n"
    start_options
    elsif choice == 3
      return 
    end 
  end 
end 


class PlayGame 
  def initialize
    get_move
  end 

  def get_move
    puts "What is your starting point?"
    start_point = gets.chomp 
    puts "What is your ending point?"
    target_point = gets.chomp
    clean_values(start_point, target_point)
    
  end 

  def clean_values(start_point, target_point)
    start_arr = start_point.split(",")
    start = start_arr.map{|x| x.to_i }

    target_arr = target_point.split(",")
    target = target_arr.map{|x| x.to_i }
    possible_outcomes(start, target)
  end 

  def possible_outcomes(start, target, counter = 0)
    knight = Node.new(start)
    p knight.position
    counter += 1
    
    return if counter == 2
    
    if start[0] == 8 
      if start[1] == 8
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter)
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter)
      elsif start[1] == 1
        knight.one = possible_outcomes([start[0]-1, start[1]+2], target, counter) 
        knight.two = possible_outcomes([start[0]+1, start[1]+2], target, counter) 
      else 
        knight.one = possible_outcomes([start[0]-1, start[1]+2], target, counter)  
        knight.two = possible_outcomes([start[0]+1, start[1]+2], target, counter) 
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter) 
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter) 
      end 
    elsif start[0] == 1
      if start[1] == 8
        knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter) 
        knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter) 

      elsif start[1] == 1
        knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter) 
        knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter) 
      else 
        knight.one = possible_outcomes([start[0]-1, start[1]+2], target, counter) 
        knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter) 
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter) 
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter) 
      end
    else 
      knight.one = possible_outcomes([start[0]-1, start[1]+2], target, counter)
      knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter)
      knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter)
      knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter)
      knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter)
      knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter)
      knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter)
      knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter)
    end
    return knight
  end 


end 

knight = Gameboard.new
knight 