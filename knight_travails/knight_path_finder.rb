require_relative '../tree_node/lib/00_tree_node'

class KnightPathFinder
  attr_reader :root
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
    @root = PolyTreeNode.new(location)
    @visited_nodes = []
  end

  def new_move_positions(parent_node)
    move_list = KnightPathFinder.valid_moves(parent_node.value)

    move_list.each do |move|
      unless @visited_nodes.map(&:value).include?(move)
        new_node = PolyTreeNode.new(move)
        new_node.parent = parent_node
        @visited_nodes << new_node
      end
    end
  end

  def build_move_tree(root)
    @visited_nodes << root
    idx = 0

    while idx < @visited_nodes.length
      current_node = @visited_nodes[idx]
      new_move_positions(current_node)
      idx += 1
    end
  end

  def find_path(end_pos)
    list = []
    found_node = @root.bfs(end_pos)

    until found_node.nil?
      list << found_node.value
      found_node = found_node.parent
    end

    list.reverse
  end
end
