# frozen_string_literal: true

require_relative('output')
require_relative('../parser')
require_relative('../pieces/pawn')
require_relative('../pieces/rook')
require_relative('../pieces/knight')
require_relative('../pieces/queen')
require_relative('../pieces/king')
require_relative('../pieces/bishop')

# A standard chessboard
class Chessboard
  attr_reader :chessboard

  def initialize
    @chessboard = Array.new(8) { Array.new(8) }
  end

  def print
    Output.print_chessboard(@chessboard)
  end

  def add_piece(player_side, piece, notation)
    new_piece = ChessParser.player_side?(player_side) ? ChessParser.create_chess_piece(player_side, piece) : nil
    rank_file = ChessParser.convert_notation(notation)
    return false if rank_file.nil? || new_piece.nil?

    @chessboard[rank_file[0]][rank_file[1]] = new_piece
    true
  end

  private

  def set_board
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
