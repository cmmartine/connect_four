require_relative '../lib/game_connect_four'

describe Game do

  describe '#insert_piece' do

    context 'when there are no pieces played yet' do

      subject(:test_game) { described_class.new }

      before do
        allow(test_game).to receive(:puts)
      end

      it 'inserts a piece in the column the player chose' do
        
      end

      it 'the second piece dropped into a column occupies the row above the first one' do

      end

      it 'does not allow more than 6 pieces in a column' do

      end
    end
  end
end