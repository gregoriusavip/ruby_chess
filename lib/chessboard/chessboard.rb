# frozen_string_literal: true

require_relative('output')
require_relative('../pieces/pawn')
require_relative('../pieces/rook')
require_relative('../pieces/knight')
require_relative('../pieces/queen')
require_relative('../pieces/king')
require_relative('../pieces/bishop')

# A standard chessboard
class Chessboard
  include Output

  def initialize
    @chessboard = Array.new(8) { Array.new(8) }
    fill_board
  end

  private

  def fill_board
    fill_pawns
    fill_white_pieces
    fill_black_pieces
  end

  def fill_pawns
    8.times { |i| @chessboard[6][i] = Pawn.new(:white) }
    8.times { |i| @chessboard[1][i] = Pawn.new }
  end

  def fill_white_pieces
    white_pieces = [Rook.new(:white), Knight.new(:white), Bishop.new(:white), King.new(:white),
                    Queen.new(:white), Bishop.new(:white), Knight.new(:white), Rook.new(:white)]
    white_pieces.each_with_index { |piece, index| @chessboard[7][index] = piece }
  end

  def fill_black_pieces
    black_pieces = [Rook.new, Knight.new, Bishop.new, King.new,
                    Queen.new, Bishop.new, Knight.new, Rook.new]
    black_pieces.each_with_index { |piece, index| @chessboard[0][index] = piece }
  end
end

Chessboard.new.print_chessboard
