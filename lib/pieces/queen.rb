# frozen_string_literal: true

require_relative('piece')

# Queen piece
class Queen < Piece
  def initialize(side = :black)
    super(side)
    @piece = queen_color
  end

  private

  def queen_color
    @side.eql?(:white) ? '♕' : '♛'
  end
end
