class Vertex
  attr_accessor :name, :location, :occupied_color, :neighbors

  def initialize(name = nil, location = nil, color = nil)
    @name = name
    @location = location
    @occupied_color = color
    @neighbors = []
  end
end
