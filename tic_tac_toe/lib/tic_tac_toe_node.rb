require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  MARKS = [:x, :o]
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
     if @board.winner == evaluator || @board.winner.nil?
       return false
     else
       return true
     end
    else
      if evaluator == next_mover_mark
        return children.all? do |child_node|
          child_node.losing_node?(evaluator)
        end
      elsif evaluator != next_mover_mark
        return children.any? do |child_node|
          child_node.losing_node?(evaluator)
        end
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    else
      if evaluator == next_mover_mark
        return children.any? do |child_node|
          child_node.winning_node?(evaluator)
        end
      elsif evaluator != next_mover_mark
        return children.all? do |child_node|
          child_node.winning_node?(evaluator)
        end
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    available_locations.map do |location|
      board_dup = @board.dup
      board_dup[location] = next_mover_mark
      TicTacToeNode.new(board_dup, get_next_marker, location)
    end
  end

  def available_locations
    locations = []
    @board.rows.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        if @board[[row_idx, col_idx]].nil?
          locations << [row_idx, col_idx]
        end
      end
    end

    locations
  end

  def get_next_marker
    MARKS.first == next_mover_mark ? MARKS.last : MARKS.first
  end
end
