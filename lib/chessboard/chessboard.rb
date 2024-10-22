# frozen_string_literal: true

require_relative('output')
require_relative('../parser')

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
    new_piece = ChessParser.create_chess_piece(piece, player_side)
    rank_file = ChessParser.convert_notation(notation)&.shift
    return false if rank_file.nil? || new_piece.nil?

    @chessboard[rank_file[0]][rank_file[1]] = new_piece
    true
  end

  private

  def set_board
    fill_pawns
    %i[white black].each { |color| fill_pieces(color) }
  end

  def fill_pawns
    8.times { |i| @chessboard[6][i] = ChessParser.create_chess_piece(:pawn, :white) }
    8.times { |i| @chessboard[1][i] = ChessParser.create_chess_piece(:pawn, :black) }
  end

  def fill_pieces(color)
    pieces = %i[rook knight bishop king queen bishop knight rook]
    rank = color.eql?(:white) ? 7 : 0
    pieces.each_with_index { |piece, index| @chessboard[rank][index] = ChessParser.create_chess_piece(piece, color) }
  end
end
