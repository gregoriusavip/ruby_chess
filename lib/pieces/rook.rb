# frozen_string_literal: true

require_relative('piece')

# Rook piece
class Rook < Piece
  def initialize(side = :black)
    super(side)
    @piece = rook_color
  end

  private

  def rook_color
    @side.eql?(:white) ? '♖' : '♜'
  end
end
