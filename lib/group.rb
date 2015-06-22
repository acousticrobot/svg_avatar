require 'json'

class Group
  attr_accessor :title, :shapes

  def initialize(title)
    @title = title
    @shapes = []
  end

  def add_shape(shape)
    @shapes << shape
  end

  def to_json(options = {})
    JSON.pretty_generate({ "title" => @title, "shapes" => @shapes })
  end
end
