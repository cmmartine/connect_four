class Vertex
  attr_accessor :name, :location, :occupied_color, :neighbors

  def initialize(name = nil, location = nil, occupied_color = 'open')
    @name = name
    @location = location
    @occupied_color = occupied_color
    @neighbors = []
  end
end
