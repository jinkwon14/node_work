class KnightPathFinder
  DIRS = [[2,1], [2,-1], [1,2], [1,-2], [-2,1], [-2,-1], [-1,2], [-1,-2]]

  def self.valid_moves(pos)
    row, col = pos
    all_moves = DIRS.map do |move|
      [row + move.first, col + move.last]
    end

    all_moves.select do |move|
      move.all? {|n| n.between?(0,7)}
    end
  end

  def initialize(location)
    @start = location
    @visited_positions = [location]
  end

  def new_move_positions(pos)
    move_list = KnightPathFinder.valid_moves(pos)
    move_list.each do |move|
      @visited_positions << move unless @visited_positions.inluce?(move)
    end
  end



  def find_path(target)

  end
end
