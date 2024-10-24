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

  describe '#convert_notation' do
    context 'when given a singular rank-file pair "a4"' do
      it 'returns a move queue of [[4, 0]]' do
        move_notation = 'a4'
        result = described_class.convert_notation(move_notation)
        expect(result).to eq([[4, 0]])
      end
    end

    context 'when given a non pair pattern "a4b"' do
      it 'returns nil' do
        move_notation = 'a4b'
        result = described_class.convert_notation(move_notation)
        expect(result).to be_nil
      end
    end

    context 'when given a wrong order pair "4b"' do
      it 'returns nil' do
        move_notation = '4b'
        result = described_class.convert_notation(move_notation)
        expect(result).to be_nil
      end
    end

    context 'when given a double rank-file pair "a4b8"' do
      it 'returns a move queue of [[4, 0], [0, 1]]' do
        move_notation = 'a4b8'
        result = described_class.convert_notation(move_notation)
        expect(result).to eq([[4, 0], [0, 1]])
      end
    end

    context 'when given more than double rank-file pair "a4b8c7"' do
      it 'returns a nil' do
        move_notation = 'a4b8c7'
        result = described_class.convert_notation(move_notation)
        expect(result).to be_nil
      end
    end
  end
end
