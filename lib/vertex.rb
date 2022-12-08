class Vertex
  attr_accessor :name, :location, :occupied_color, :neighbors

  def initialize(name, location, color = nil)
    @name = name
    @location = location
    @occupied_color = color
    @neighbors = []
  end
