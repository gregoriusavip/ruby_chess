# frozen_string_literal: true

require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/knight')
require_relative('pieces/queen')
require_relative('pieces/king')
require_relative('pieces/bishop')

# Utility class to parse chess notations/inputs
class ChessParser
  def self.create_chess_piece(piece, player_side)
    { pawn: -> { Pawn.new }, king: -> { King.new }, queen: -> { Queen.new }, rook: -> { Rook.new },
      knight: -> { Knight.new }, bishop: -> { Bishop.new } }[piece]
  end

  def self.player_side?(side)
    Set[:white, :black].include? side
  end

  def self.convert_notation(notation)
    [4, 0]
  end
end
