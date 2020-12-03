class Knight

  attr_accessor :pos

  def initialize(pos=[3,1])
    @pos = pos
  end

  def get_moves(pos=@pos)
    moves = []
    x = pos[0]
    y = pos[1]

    potentials = [[x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2],
                  [x + 2, y + 1], [x + 2, y - 1], [x - 2, y - 1], [x - 2, y + 1]]
    possibles = []
    potentials.each do |move|
      possibles << move if Board.allowed? move
    end
    possibles
  end

  def knight_moves(start, finish)
    path = Path.new(start, finish, self)
  end

end