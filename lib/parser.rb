# frozen_string_literal: true

require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/knight')
require_relative('pieces/queen')
require_relative('pieces/king')
require_relative('pieces/bishop')

# Utility class to parse chess notations/inputs
class ChessParser
  @pieces = { pawn: ->(color) { Pawn.new(color) }, king: ->(color) { King.new(color) },
              queen: ->(color) { Queen.new(color) }, rook: ->(color) { Rook.new(color) },
              knight: ->(color) { Knight.new(color) }, bishop: ->(color) { Bishop.new(color) } }

  def self.create_chess_piece(piece, color)
    return nil unless Set[:white, :black].include? color

    new_piece = @pieces[piece]
    new_piece&.call(color)
  end

  def self.convert_notation(notation)
    [4, 0]
  end
end
