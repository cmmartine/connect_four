class Vertex
  attr_accessor :name, :location, :occupied_color, :neighbors

  def initialize(name = nil, location = nil)
    @name = name
    @location = location
    @occupied_color = 'open'
    @neighbors = []
  end
end
