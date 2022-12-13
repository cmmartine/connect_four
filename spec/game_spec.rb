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

  describe '#change_players' do

    subject(:test_game) { described_class.new }

    context 'when current_player is player_one' do

      it 'changes current_player to player_two' do
        test_game.change_players
        expect(test_game.instance_variable_get(:@current_player)).to eq('➁')
      end
    end

    context 'when current_player is player_two' do

      it 'changes current_player to player_one' do
        test_game.instance_variable_set(:@current_player, '➁')
        test_game.change_players
        expect(test_game.instance_variable_get(:@current_player)).to eq('➊')
      end
    end
  end

  describe '#horizontal_win_status' do

    context 'when four horizontal positions which are neighbors have same occupied color' do
      subject(:test_game) { described_class.new(test_board) }
      let(:test_board) { Board.new([f1, f2, f3, f4]) }
      let(:f1) { Vertex.new('f1', [6, 1], '➊') }
      let(:f2) { Vertex.new('f2', [6, 2], '➊') }
      let(:f3) { Vertex.new('f3', [6, 3], '➊') }
      let(:f4) { Vertex.new('f4', [6, 4], '➊') }

      it 'changes win_status to the current player' do
        expect { test_game.horizontal_win_status }.to change { test_game.instance_variable_get(:@win_status) }.from(nil).to('➊')
      end

    end

    context 'when three horizontal positions which are neighbors have same occupied color' do

      subject(:test_game) { described_class.new(test_board) }
      let(:test_board) { Board.new([f1, f2, f3, f4]) }
      let(:f1) { Vertex.new('f1', [6, 1], '➊') }
      let(:f2) { Vertex.new('f2', [6, 2], '➊') }
      let(:f3) { Vertex.new('f3', [6, 3], '➊') }
      let(:f4) { Vertex.new('f4', [6, 4], '➁') }

      it 'returns without changing win_status' do
        test_game.horizontal_win_status
        expect(test_game.instance_variable_get(:@win_status)).not_to be('➊')
      end

    end

    context "when three horizontal positions which are neighbors at the end of a line, and the position next in the array ex: 'f1, f2, f3, e7' contain same occupied color"  do

      subject(:test_game) { described_class.new(test_board) }
      let(:test_board) { Board.new([f1, f2, f3, e7]) }
      let(:f1) { Vertex.new('f1', [6, 1], '➊') }
      let(:f2) { Vertex.new('f2', [6, 2], '➊') }
      let(:f3) { Vertex.new('f3', [6, 3], '➊') }
      let(:e7) { Vertex.new('e7', [5, 7], '➊') }

      it 'returns without changing win_status' do
        test_game.horizontal_win_status
        expect(test_game.instance_variable_get(:@win_status)).not_to be('➊')
      end

    end

  end
end