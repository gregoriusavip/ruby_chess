# frozen-string-literal: true

require_relative '../lib/parser'
require_relative '../lib/pieces/knight'

describe ChessParser do
  describe '#create_chess_piece' do
    context 'when the color is not white or black' do
      it 'returns nil' do
        color = :red
        result = described_class.create_chess_piece(:piece, color)
        expect(result).to be_nil
      end
    end

    context 'when the color is valid but the piece is invalid' do
      it 'returns nil' do
        color = :white
        piece = :horse
        result = described_class.create_chess_piece(piece, color)
        expect(result).to be_nil
      end
    end

    context 'when the color is valid and the piece is knight' do
      it 'returns a new knight object' do
        color = :white
        piece = :knight
        result = described_class.create_chess_piece(piece, color)
        expect(result).to be_a Knight
      end
    end
  end
end
