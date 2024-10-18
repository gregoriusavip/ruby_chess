# frozen_string_literal: true

require_relative('piece')

# Pawn piece
class Pawn < Piece
  def initialize(side = :black)
    super(side)
    @piece = pawn_color
  end

  private

  def pawn_color
    @side.eql?(:white) ? '♙' : '♟'
  end
end
