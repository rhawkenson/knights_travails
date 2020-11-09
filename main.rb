#=====Psuedocode=====
# 1. Create UI with knight and gameboard 
# 2. Possible moves are node children in a tree 
#     - The user chooses the starting point and end point
# 3. Use a search algorithm to traverse the tree 
# 4. Use the search algorithm to find the shortest path to the ending point  

#=====Guide to node names=====
# The nodes 1-8 represent the possible outcomes move for the knight
# The possible nodes start on the top left and work clockwise around the knight 
# In the board below, [2,5] would be possibility 1, [3,6] would be possibility 2, and so on 
# "8___|___|___|___|___|___|___|___|"
# "7___|___|___|___|___|___|___|___|"
# "6___|___|_2_|___|_3_|___|___|___|"
# "5___|_1_|___|___|___|_4_|___|___|"
# "4___|___|___|_X_|___|___|___|___|"
# "3___|_8_|___|___|___|_5_|___|___|"
# "2___|___|_7_|___|_6_|___|___|___|"
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
    puts "8|___|___|___|___|___|___|___|___|"
    puts "7|___|___|___|___|___|___|___|___|"
    puts "6|___|___|___|___|___|___|___|___|"
    puts "5|___|___|___|___|___|___|___|___|"
    puts "4|___|___|___|___|___|___|___|___|"
    puts "3|___|___|___|___|___|___|___|___|"
    puts "2|___|___|___|___|___|___|___|___|"
    puts "1|___|___|___|___|___|___|___|___|"
    puts "   1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"
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
      demonstration 
      start_options
    elsif choice == 3
      return 
    end 
  end 

  def demonstration 
    puts "First you will choose your starting point. Let's select [4,4]. You knight is shown on [4,4] with an 'X'.
    Next, you will choose your desired ending point. For demonstrative purposes, we will choose [3,3].
    From your starting point, your knight can move in an L-shape. That means they can move 2 blocks in any
    direction, and then one block in a different direction. The knight cannot travel diagonally. 
    From [4,4], the possible outcomes for the next move are marked with '*'.
    
    \n\n"
    puts "8|___|___|___|___|___|___|___|___|"
    puts "7|___|___|___|___|___|___|___|___|"
    puts "6|___|___|_*_|___|_*_|___|___|___|"
    puts "5|___|_*_|___|___|___|_*_|___|___|"
    puts "4|___|___|___|_X_|___|___|___|___|"
    puts "3|___|_*_|___|___|___|_*_|___|___|"
    puts "2|___|___|_*_|___|_*_|___|___|___|"
    puts "1|___|___|___|___|___|___|___|___|"
    puts "   1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"

    puts "\n\nIf we travel to [2,5] next, we can get
    to our target of [3,3] in 2 moves. [3,3] is marked with 'O'.
    \n\n"
    puts "8|___|___|___|___|___|___|___|___|"
    puts "7|_*_|___|_*_|___|___|___|___|___|"
    puts "6|___|___|___|_*_|___|___|___|___|"
    puts "5|___|_X_|___|___|___|___|___|___|"
    puts "4|___|___|___|_*_|___|___|___|___|"
    puts "3|_*_|___|_O_|___|___|___|___|___|"
    puts "2|___|___|___|___|___|___|___|___|"
    puts "1|___|___|___|___|___|___|___|___|"
    puts "   1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"

    puts "\n\n
    When you enter your starting and ending point, the computer will tell you the most 
    efficient route and count the least possible moves for you. Let's play!!\n\n"
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

  def possible_outcomes(start, target, counter = 0, arr = [])
    knight = Node.new(start)
    arr << start
    counter+= 1

    
    return knight.position if start == target
    if start[0] >= 8 
      if start[1] >= 8
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter, arr)
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter, arr)
      elsif start[1] <= 1
        knight.one = possible_outcomes([start[0]-2, start[1]+2], target, counter, arr)
        knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
      else 
        knight.one = possible_outcomes([start[0]-2, start[1]+2], target, counter, arr)
        knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter, arr)
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter, arr)
      end 
    elsif start[0] <= 1
      if start[1] >= 8
        knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter, arr)
        knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter, arr)
      elsif start[1] <= 1
        knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter, arr)
        knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter, arr)
      else
        knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter, arr)
        knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter, arr)
        knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter, arr)
        knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter, arr)
      end
    else 
      if start[1] >= 8
        knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter, arr)
        knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter, arr)
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter, arr)
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter, arr)
      elsif start[1] <= 1
        knight.one = possible_outcomes([start[0]-2, start[1]+2], target, counter, arr)
        knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
        knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter, arr)
        knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter, arr)
      else 
        knight.one = possible_outcomes([start[0]-2, start[1]+2], target, counter, arr)
        knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
        knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter, arr)
        knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter, arr)
        knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter, arr)
        knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter, arr)
        knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter, arr)
        knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter, arr)
      end 
    end
    return knight
  end 


end 

knight = Gameboard.new

# knight.one = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
# knight.two = possible_outcomes([start[0]-1, start[1]+2], target, counter, arr)
# knight.three = possible_outcomes([start[0]+1, start[1]+2], target, counter, arr)
# knight.four = possible_outcomes([start[0]+2, start[1]+1], target, counter, arr)
# knight.five = possible_outcomes([start[0]+2, start[1]-1], target, counter, arr)
# knight.six = possible_outcomes([start[0]+1, start[1]-2], target, counter, arr)
# knight.seven = possible_outcomes([start[0]-1, start[1]-2], target, counter, arr)
# knight.eight = possible_outcomes([start[0]-2, start[1]-1], target, counter, arr)