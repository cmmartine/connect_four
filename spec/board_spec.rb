require_relative '../lib/board.rb'

describe Board do

  before(:all) do
    @original_stdout = $stdout
    @original_stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  after(:all) do
    $stdout = @original_stdout
    $stderr = @original_stderr
    @original_stdout = nil
    @original_stderr = nil
  end

  describe '#create_vertexes' do

    context 'Establish all vertexes' do
      subject(:test_game) { described_class.new }
      subject(:game_vertex) { instance_double(Vertex) }

      it 'creates 42 vertexes' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices.count).to eq(42)
      end

      it 'inserts a name for each vertex - first vertex is a1' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices[0].name).to eq('a1')
      end

      it 'inserts a name for each vertex - last vertex is f7' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices[41].name).to eq('f7')
      end

      it 'inserts a location for each vertex - first vertex is [1, 1]' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices[0].location).to eq([1, 1])
      end

      it 'inserts a location for each vertex - last vertex is [6, 7]' do
        vertices = test_game.instance_variable_get(:@vertices)
        test_game.create_vertexes
        expect(vertices[41].location).to eq([6, 7])
      end
    end
  end

  describe '#letter_selector' do

    context 'Selects the correct letter to name the vertex' do

      subject(:test_game) { described_class.new }

      it "returns 'a' when the location is in the [1, x] row" do
        location = 1
        letter = test_game.letter_selector(location)
        expect(letter).to eq('a')
      end

      it "returns 'e' when the location is in the [5, x] row" do
        location = 5
        letter = test_game.letter_selector(location)
        expect(letter).to eq('e')
      end
    end
  end

  describe '#get_neighbor_locations' do
    subject(:test_game) { described_class.new }
    subject(:game_vertex) { instance_double(Vertex) }

    context 'determines neighbors locations' do

      it 'returns locations [ [1,2], [2, 1], [2, 2] ] for spot a1 neighbors' do
        a1_location = [1, 1]
        neighbor_locations = test_game.get_neighbor_locations(a1_location)
        expect(neighbor_locations).to eq([[1, 2], [2, 1], [2, 2]])
      end

      it 'returns locations [ [3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5] ] for spot d4 neighbors' do
        d4_location = [4, 4]
        neighbor_locations = test_game.get_neighbor_locations(d4_location)
        expect(neighbor_locations).to eq([[3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]])
      end

      it 'returns locations [ [5, 6], [5, 7], [6, 6] ] for spot f7 neighbors' do
        f7_location = [6, 7]
        neighbor_locations = test_game.get_neighbor_locations(f7_location)
        expect(neighbor_locations).to eq([[5, 6], [5, 7], [6, 6]])
      end
    end
  end

  describe '#determine_neighbors' do

    subject(:test_game) { described_class.new }
    subject(:game_vertex) { instance_double(Vertex) }

    context 'determines neighbors index in vertices variable' do

      it 'returns all neighbor index locations for spot d4' do
        test_game.create_vertexes
        vertices = test_game.instance_variable_get(:@vertices)
        d4_neighbor_locations = [[3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]]
        d4_neighbors = test_game.determine_neighbors(d4_neighbor_locations, vertices)
        d4_checked_neighbors = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, true, true, nil, nil, nil, nil, true, nil, true, nil, nil, nil, nil, true, true, true, nil, nil, nil, nil, nil, nil, nil, nil, nil]
        expect(d4_neighbors).to eq(d4_checked_neighbors)
      end
    end
  end

  describe '#populate_columns_array' do

    context 'makes a subarray of indexes for each column' do

      subject(:test_game) { described_class.new }

      it 'inserts the first column into @columns' do
        column = test_game.instance_variable_get(:@columns)
        test_game.populate_columns_array
        expect(column[0]).to eq([0, 7, 14, 21, 28, 35])
      end

      it 'inserts the last column into @columns' do
        column = test_game.instance_variable_get(:@columns)
        test_game.populate_columns_array
        expect(column[6]).to eq([6, 13, 20, 27, 34, 41])
      end
    end
  end
end