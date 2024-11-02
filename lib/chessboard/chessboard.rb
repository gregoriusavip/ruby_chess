# frozen_string_literal: true

require_relative('output')
require_relative('../parser')

# A standard chessboard
class Chessboard
  attr_reader :chessboard, :white_pieces, :black_pieces

  def initialize
    @chessboard = Array.new(8) { Array.new(8) }
    @white_pieces = []
    @black_pieces = []
  end

  def print
    Output.print_chessboard(@chessboard)
  end

  def add_piece(player_side, piece, notation)
    new_piece = ChessParser.create_chess_piece(piece, player_side)
    rank_file = ChessParser.convert_notation(notation)&.shift
    return false if rank_file.nil? || new_piece.nil?

    @chessboard[rank_file[0]][rank_file[1]] = new_piece
    player_side.eql?(:white) ? (@white_pieces << new_piece) : (@black_pieces << new_piece)
    true
  end

  def set_board
    # assumes the board is empty and no pieces created yet
    %i[white black].each { |color| fill_pieces(color) }
  end

  private

  def fill_pieces(color)
    fill_pawns(color)
    pieces = %i[rook knight bishop king queen bishop knight rook]
    pieces_side = color.eql?(:white) ? @white_pieces : @black_pieces
    row = color.eql?(:white) ? 7 : 0
    pieces.each_with_index do |piece, column|
      pieces_side << ChessParser.create_chess_piece(piece, color)
      @chessboard[row][column] = pieces_side.last
    end
  end

  def fill_pawns(color)
    pieces_side = color.eql?(:white) ? @white_pieces : @black_pieces
    row = color.eql?(:white) ? 6 : 1
    8.times do |column|
      pieces_side << ChessParser.create_chess_piece(:pawn, color)
      @chessboard[row][column] = pieces_side.last
    end
  end
end
