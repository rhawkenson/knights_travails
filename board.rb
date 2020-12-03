require_relative 'knight'

class Board

  attr_reader :squares

    @@squares = []
    for i in 1..8
      for j in 1..8
        @@squares << [i,j]
      end
    end


  def self.allowed?(move)
    return false unless @@squares.include? move
    return true
  end

end

class Node
  attr_reader :pos
  attr_accessor :parent, :children
  def initialize(pos, parent=nil, children=nil)
    @pos = pos
    @parent = parent
    @children = children
  end
end

class Path
  def initialize(start, finish, piece)
    @piece = piece
    @start = Node.new(start, nil, nil)
    @finish_pos = finish
    make_path(@start, finish)
  end

  def make_path(start, finish)
    @queue = []
    @found = false
    @piece.pos = @start.pos
    
    current = @start
    @queue << current
    @steps = 0

    until @queue.empty? or @found
      get_children(current)
      check_children(current)
      current = @queue.shift
    end

  end

  def get_children(node)
    children = []
    @piece.get_moves(node.pos).each do |move|
      children << Node.new(move, node)
    end
    node.children = children
  end

  def check_children(node)
    node.children.each do |child|
      if child.pos == @finish_pos
        found_finish(child, node)
      else
        @queue << child
      end
    end
  end

  def found_finish(node, parent)
    @finish = Node.new(node, parent)
    @found = true
    get_steps
  end

  def get_steps
    @path = []
    @result = []
    steps = 0
    current = @finish.pos
    until current.parent.nil?
      @path << current.pos
      current = current.parent
    end
    @path << @start.pos
    @path.reverse!.each do |pos|
      unless pos == @path.last 
        @result << "#{pos}-> "
      else
        @result << "#{pos}"
      end
      steps += 1
    end
    p "Path found in #{steps} steps"
    p @result.join
  end
end

board = Board.new

knight = Knight.new

knight.knight_moves([3,1], [8,8])

# >> "[3, 1]-> [4, 3]-> [5, 5]-> [6, 7]-> [8, 8]"