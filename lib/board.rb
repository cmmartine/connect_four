require_relative '../lib/vertex'

class Board
  attr_accessor :board
  attr_reader :vertices

  def initialize
    @board = [
      ['  ', '  1', '  2', '  3', '  4', '  5', '  6', '  7', "\n"],
      ['a ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['b ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['c ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['d ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['e ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['f ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"]
    ]
    @vertices = []
  end

  def create_board
    create_vertexes
    populate_neighbors
  end

  def create_vertexes
    i = 1
    while i <= 6
      j = 1
      while j <= 7
        letter = letter_selector(i)
        @vertices << Vertex.new(letter + j.to_s, [i, j])
        j += 1
      end
      i += 1
    end
  end

  def letter_selector(number)
    case number
    when 1
      'a'
    when 2
      'b'
    when 3
      'c'
    when 4
      'd'
    when 5
      'e'
    when 6
      'f'
    else
      return
    end
  end

  def populate_neighbors
    @vertices.each do |vert|
      neighbor_locations = get_neighbor_locations(vert.location)
      neighbor_array = determine_neighbors(neighbor_locations)
      vert.neighbors = neighbor_array
    end
  end

  def get_neighbor_locations(current)
    location_math = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    neighbor_locations = []
    location_math.each do |math|
      potential_neighbor = [(current[0] + math[0]), (current[1] + math[1])]
      unless potential_neighbor[0].zero? || potential_neighbor[0] > 6 || potential_neighbor[1].zero? || potential_neighbor[1] > 7
        neighbor_locations << potential_neighbor
      end
    end
    neighbor_locations
  end

  def determine_neighbors(neighbor_locations, vertices = @vertices)
    i = 0
    neighbors = []
    vertices.each do |vert|
      if neighbor_locations.include?(vert.location)
        neighbors[i] = true
      else
        neighbors[i] = nil
      end
      i += 1
    end
    neighbors
  end
end

board = Board.new
board.create_board