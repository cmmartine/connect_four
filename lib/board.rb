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
    p @vertices
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
end
