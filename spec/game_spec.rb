require_relative '../lib/game_connect_four'

describe Game do

  describe '#insert_piece' do

    context 'when there are no pieces played yet' do

      subject(:test_game) { described_class.new(test_board) }
      let(:test_board) { Board.new([test_vertex, test_vertex2]) }
      let(:test_vertex) { Vertex.new('f1', [6, 1]) }
      let(:test_vertex2) { Vertex.new('e1', [5, 1]) }

      before do
        allow(test_game).to receive(:player_choice) { 1 }
        allow(test_game).to receive(test_vertex.occupied_color)
      end

      it 'inserts a piece in the column the player chose' do
        test_game.insert_piece(1, [0, 1])
        expect(test_vertex.instance_variable_get(:@occupied_color)).to eq('➊')
      end

      it 'does not insert a piece into the vertex above the space chosen' do
        test_game.insert_piece(1, [0, 1])
        expect(test_vertex2.instance_variable_get(:@occupied_color)).not_to eq('➊')
      end

    end

    context 'when the chosen columns first row is occupied' do

      subject(:test_game) { described_class.new(test_board) }
      let(:test_board) { Board.new([test_vertex, test_vertex2]) }
      let(:test_vertex) { Vertex.new('f1', [6, 1]) }
      let(:test_vertex2) { Vertex.new('e1', [5, 1]) }

      before do
        allow(test_game).to receive(:player_choice) { 1 }
        allow(test_game).to receive(test_vertex.occupied_color)
      end

      it 'inserts a piece in the second row of the column' do
        2.times do
          test_game.insert_piece(1, [0, 1])
        end
        expect(test_vertex2.instance_variable_get(:@occupied_color)).to eq('➊')
      end
    end
  end
end