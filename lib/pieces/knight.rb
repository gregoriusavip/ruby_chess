# frozen_string_literal: true

require_relative('piece')

# Knight piece
class Knight < Piece
  def initialize(side = :black)
    super(side)
    @piece = knight_color
  end

  private

  def knight_color
    @side.eql?(:white) ? '♘' : '♞'
  end
end
