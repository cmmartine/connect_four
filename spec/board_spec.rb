require_relative '../lib/board.rb'

describe Board do

  describe "#create_vertexes" do

    context 'Establish all vertexes' do
      subject(:test_game) { described_class.new }

      it 'creates 42 vertexes' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices.count).to eq(42)
      end
    end
  end

  describe "#letter_selector" do

    context 'Selects the correct letter to name the vertex' do

      subject(:test_game) { described_class.new }

      it "returns 'a' when the location is in the [1, x] row" do
        location = 1
        letter = test_game.letter_selector(location)
        expect(letter).to eq("a")
      end

      it "returns 'e' when the location is in the [5, x] row" do
        location = 5
        letter = test_game.letter_selector(location)
        expect(letter).to eq("e")
      end
    end
  end
end