# frozen-string-literal: true

require_relative '../../lib/chessboard/chessboard'
require_relative '../../lib/parser'

describe Chessboard do
  describe '#add_piece' do
    subject(:empty_chessboard) { described_class.new }

    before do # expect this unless stated otherwise within the test context
      allow(ChessParser).to receive_messages(create_chess_piece: :knight, player_side?: true,
                                             convert_notation: [4, 0])
    end

    context 'when adding an invalid horse chess piece' do
      it 'fails to add the piece and returns false' do
        allow(ChessParser).to receive(:create_chess_piece).and_return(nil)
        invalid_piece = :horse
        result = empty_chessboard.add_piece(:white, invalid_piece, 'a4')
        expect(result).to be false
      end
    end

    context 'when adding a valid knight chess piece' do
      it 'returns true' do
        allow(ChessParser).to receive(:create_chess_piece).and_return(:knight)
        valid_piece = :knight
        result = empty_chessboard.add_piece(:white, valid_piece, 'a4')
        expect(result).to be true
      end
    end

    context 'when adding a chess piece with the wrong side' do
      it 'returns false' do
        allow(ChessParser).to receive(:player_side?).and_return(false)
        invalid_side = :red
        result = empty_chessboard.add_piece(invalid_side, :knight, 'a4')
        expect(result).to be false
      end
    end

    context 'when adding a chess piece with a known side' do
      it 'returns true' do
        allow(ChessParser).to receive(:player_side?).and_return(true)
        valid_side = :white
        result = empty_chessboard.add_piece(valid_side, :knight, 'a4')
        expect(result).to be true
      end
    end

    context 'when adding a chess piece with a valid position notation' do
      it 'returns true' do
        allow(ChessParser).to receive(:convert_notation).and_return([4, 0])
        valid_notation = 'a4'
        result = empty_chessboard.add_piece(:black, :knight, valid_notation)
        expect(result).to be true
      end
    end

    context 'when adding a chess piece with an invalid position notation' do
      it 'returns false' do
        allow(ChessParser).to receive(:convert_notation).and_return(nil)
        invalid_notation = 'a10'
        result = empty_chessboard.add_piece(:black, :knight, invalid_notation)
        expect(result).to be false
      end
    end

    context 'when adding a completely valid piece' do
      it 'adds the piece to the board' do
        expect { empty_chessboard.add_piece(:white, :knight, 'a4') }.to change {
          empty_chessboard.chessboard[4][0]
        }.from(nil)
      end
    end

    context 'when there is an invalid argument' do
      it 'does not change the chessboard' do
        allow(ChessParser).to receive(:convert_notation).and_return(nil)
        expect { empty_chessboard.add_piece(:white, :knight, 'invalid_notation') }.not_to(
          change(empty_chessboard, :chessboard)
        )
      end
    end
  end
end
