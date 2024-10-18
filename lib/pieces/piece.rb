# frozen_string_literal: true

# Base class for any of the chess piece
class Piece
  attr_reader :piece

  def initialize(side = :black)
    @side = side
  end
end
