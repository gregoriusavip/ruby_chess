# frozen_string_literal: true

# Handles board visualization
module BoardOutput
  def print_board
    order = 1
    @chessboard.each do |ranks|
      ranks.each do |piece|
        print("#{piece.nil? ? colored_square(order) : piece.piece} ")
        order += 1
      end
      puts
      order -= 1
    end
  end

  private

  def colored_square(order)
    (order % 2).eql?(0) ? '□' : '■'
  end
end
