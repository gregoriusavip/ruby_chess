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
    return nil if notation.length > 4 || notation.length.odd?

    moves = []
    notation.chars.each_slice(2) do |sliced_move|
      result = string_to_coords(sliced_move[0], sliced_move[1])
      result.nil? ? (return nil) : moves << result
    end
    moves
  end

  # takes a singular pair of a notation and convert it to positional coordinate
  def self.string_to_coords(file, rank)
    move = []
    file.match?(/[a-h]/) ? move.unshift(file.ord - 'a'.ord) : (return nil)
    rank.match?(/[1-8]/) ? move.unshift(8 - rank.to_i) : (return nil)
    move
  end
end
