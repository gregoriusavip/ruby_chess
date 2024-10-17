# frozen_string_literal: true

require_relative('board_output')

# A standard chessboard
class Board
  include BoardOutput

  def initialize
    @chessboard = Array.new(8) { Array.new(8) }
    fill_board
  end

  private

  def fill_board
    fill_black_pawns
    fill_white_pawns
    fill_white_pieces
    fill_black_pieces
  end

  def fill_white_pawns
    8.times { |i| @chessboard[6][i] = '♙' }
  end

  def fill_black_pawns
    8.times { |i| @chessboard[1][i] = '♟' }
  end

  def fill_white_pieces
    l = 0
    r = 7
    ['♖', '♘', '♗', '♕', '♔'].each do |piece|
      @chessboard[7][l] = piece
      @chessboard[7][r] = piece if r >= 5
      l += 1
      r -= 1
    end
  end

  def fill_black_pieces
    l = 0
    r = 7
    ['♜', '♞', '♝', '♛', '♚'].each do |piece|
      @chessboard[0][l] = piece
      @chessboard[0][r] = piece if r >= 5
      l += 1
      r -= 1
    end
  end
end
