require 'json'

class Index
  attr_reader :components

  def initialize()
    @components = {} # "faces", "torsos", etc.
  end

  def add_component(component)
    @components[component] = []
  end

  def add_group(group, component)
    @components[component] << group
  end

  def save(writer)
    writer.write_to_file("js/defs.js", self.to_json)
  end

  def to_json(options = {})
    "var avatarGroups = #{JSON.pretty_generate(@components)}"
  end
end
