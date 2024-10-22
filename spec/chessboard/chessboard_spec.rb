# frozen-string-literal: true

require_relative '../../lib/chessboard/chessboard'
require_relative '../../lib/parser'

describe Chessboard do
  describe '#add_piece' do
    subject(:empty_chessboard) { described_class.new }

    before do # expect this unless stated otherwise within the test context
      allow(ChessParser).to receive_messages(create_chess_piece: :knight, convert_notation: [4, 0])
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
  end
end
