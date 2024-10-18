# frozen_string_literal: true

# Handles board visualization
module BoardOutput
  def print_chessboard
    counter = 1
    @chessboard.each_with_index do |ranks, rank_index|
      print "#{8 - rank_index} "
      ranks.each_with_index do |piece, order|
        print("#{piece.nil? ? alt_square(order + counter) : piece.piece} ")
      end
      print "\n"
      counter -= 1
    end
    print_chessboard_files
  end

  private

  def print_chessboard_files
    print '  '
    8.times { |i| print("#{('a'.ord + i).chr} ") }
    puts
  end

  def alt_square(order)
    (order % 2).eql?(0) ? '□' : '■'
  end
end
