# frozen-string-literal: true

require_relative '../../lib/chessboard/chessboard'
require_relative '../../lib/parser'

describe Chessboard do
  describe '#add_piece' do
    subject(:empty_chessboard) { described_class.new }

    before do # expect this unless stated otherwise within the test context
      allow(ChessParser).to receive_messages(create_chess_piece: :knight, convert_notation: [[4, 0]])
    end

    context 'when create_chess_piece returns nil' do
      it 'fails to add the piece and returns false' do
        allow(ChessParser).to receive(:create_chess_piece).and_return(nil)
        invalid_piece = :horse
        result = empty_chessboard.add_piece(:white, invalid_piece, 'a4')
        expect(result).to be false
      end
    end

    context 'when convert_notation returns nil' do
      it 'returns false' do
        allow(ChessParser).to receive(:convert_notation).and_return(nil)
        invalid_notation = 'a10'
        result = empty_chessboard.add_piece(:black, :knight, invalid_notation)
        expect(result).to be false
      end
    end

    context 'when create_chess_piece and conver_notation are valid' do
      it 'adds the piece to the board' do
        expect { empty_chessboard.add_piece(:white, :knight, 'a4') }.to change {
          empty_chessboard.chessboard[4][0]
        }.from(nil)
      end
    end

    context 'when adding a white piece' do
      it 'adds the new piece to the white pieces list' do
        expect { empty_chessboard.add_piece(:white, :knight, 'a4') }.to change {
          empty_chessboard.white_pieces.last
        }.to eq :knight
      end
    end

    context 'when adding a black piece' do
      it 'adds the new piece to the black pieces list' do
        expect { empty_chessboard.add_piece(:black, :knight, 'a4') }.to change {
          empty_chessboard.black_pieces.last
        }.to eq :knight
      end
    end
  end

  describe '#set_board' do
    subject(:after_set) { described_class.new }

    before do
      %i[pawn rook knight bishop king queen].each do |piece|
        allow(ChessParser).to receive(:create_chess_piece).with(piece, :white).and_return(piece)
        allow(ChessParser).to receive(:create_chess_piece).with(piece, :black).and_return(piece)
      end
      after_set.set_board
    end

    context 'when setting the pieces' do
      pieces_order = %i[rook knight bishop king queen bishop knight rook]
      [[0, 1], [7, 6]].each_with_index do |rows, color|
        color = color.even? ? :black : :white
        it "puts all 8 non-pawn #{color} pieces in the right order of row #{rows[1]}" do
          expect(after_set.chessboard[rows[0]]).to eq(pieces_order)
        end

        it "puts all 8 #{color} pawns on the entire column of row #{rows[0]}" do
          expect(after_set.chessboard[rows[1]].all?(:pawn)).to be true
        end
      end

      all_pieces = %i[rook knight bishop king queen bishop knight rook]
      8.times { all_pieces << :pawn }

      it 'stores all of white pieces on a list' do
        expect(after_set.white_pieces).to match_array(all_pieces)
      end

      it 'stores all of black pieces on a list' do
        expect(after_set.black_pieces).to match_array(all_pieces)
      end
    end
  end
end
