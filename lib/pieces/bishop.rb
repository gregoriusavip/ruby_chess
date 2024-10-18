# frozen_string_literal: true

require_relative('piece')

# Bishop piece
class Bishop < Piece
  def initialize(side = :black)
    super(side)
    @piece = bishop_color
  end

  private

  def bishop_color
    @side.eql?(:white) ? '♗' : '♝'
  end
end
