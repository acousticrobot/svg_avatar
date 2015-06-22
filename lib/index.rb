require 'json'

class Index
  attr_reader :faces, :groups

  def initialize()
    @faces = []
    @groups = []
  end

  def add_face(face)
    @faces << face
  end

  def add_group(group)
    @groups << group
  end

  def save(writer)
    writer.write_to_file("index.js", self.to_json)
  end

  def to_json(options = {})
    JSON.pretty_generate({ "avatarGroups" => {
      "faces" => @faces,
      "groups" => @groups
    }})
  end
end
