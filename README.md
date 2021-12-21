# Knight's Travails 
#### This is my solution to the Knight's Travails project from [The Odin Project](https://www.theodinproject.com)
_______________________________________________________________
#### Purpose:
This project is designed to test the learner's knowledge of recursion and binary search trees. The program will take in start and target values and the programmer is challenged to decide the best traversal algorithm. In the end, the program will return the most efficient route of a knight (such as in chess) from start to target. 

##### Psuedocode:
  1. Create a knight class that generates new nodes
  2. Acquire all possible moves of the current knight's position
  3. Check the possible second moves of the current knight's position for the target
  4. Begin traversing the possible moves and their children for the target
  5. Stop and end the search when the target has been found

##### Global Method
  #### Method
    #knight_moves 
      - Returns "done" if the start and target are equal and the knight requires no moves
      - Verifies that the start and target are legal moves 
      - Creates a new instance of class Pathway using the start and target values, starting the game

### Class Knight
  #### Methods 
    #initialize
      - Create new nodes that have data(location of the knight), parent(position that lead to this possible move), and children(possible moves)

### Class Pathway 
  #### Methods 
    #initialize
      - Start and Target are passed when a new class is created
      - The start value determines the first position the knight will be in
      - The target value determines the stopping condition of the recursion
      - The knight is stored in an array, "visited" so that it can be assigned as a parent to the children (possible moves) that will be created in #make_nodes

    #valid
      - Checks if a child's coordinates are on the board

    #get_children 
      - Assigns children to the current knight
      - Runs the coordinates through 8 algebraic equations and only keeps ones returning "true" from #valid

    #make_nodes
      - The most important method of the program 
      - Takes all children (possible moves) and makes them independent nodes with children and parents 
      - Adds children to a queue to be evaluated one at time 
      - Adds nodes to an array, visited, to be used as parent nodes
      - Stops recursion when the target is found within the current node's children

    #path
      - Displays the shortest path the knight can take from start to target 

    #count_steps
      - Displays the number of steps the knight will need to take in order to reach the target
  
