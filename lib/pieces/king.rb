# frozen_string_literal: true

require_relative('piece')

# King piece
class King < Piece
  def initialize(side = :black)
    super(side)
    @piece = king_color
  end

  private

  def king_color
    @side.eql?(:white) ? '♔' : '♚'
  end
end
