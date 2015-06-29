require 'json'

class Shape

  FILL = /fill\=\"(\#[A-Fa-f0-9]+)\"/

  attr_accessor :type, :attrs

  def initialize(svg)
    if svg.match(FILL)
      case svg.match(FILL)[1]
      when "#FFFFFF"
        class_attr = "color-bright"
      when "#808080"
      when "#999999"
        class_attr = "color-primary"
      when "#000000"
        class_attr = "color-dark"
      else
        class_attr = "color-primary"
      end
    else
       class_attr = "color-dark"
    end
    @attrs = {"class" => class_attr}
    @type = "generic shape"
  end

  def add_attr(k,v)
    @attrs[k] = v
  end

  def to_json(options = {})
    { "type"=>@type,"attr"=>@attrs }.to_json
  end
end

# <path fill="#000000" d="M156.751,31.5c0-5.799-10.5-10.5-10.5-10.5s-10.5,4.701-10.5,10.5s4.701,10.5,10.5,10.5S156.751,37.299,156.751,31.5z"/>
# {"type":"path","attr":{"d":"M90.001,21c0,0-20.147,21-45,21C20.148,42,0,21,0,21s20.147-21,45-21C69.854,0,90.001,21,90.001,21z","class":"bright-color"}},
#
class Path < Shape
  D = /d\=\"([^\"]+)\"/

  def initialize(svg)
    super
    @type = "path"
    @attrs["d"] = svg.match(D)[1]
  end
end

#<rect x="73" y="105" width="20" height="20"/>
class Rect < Shape
  X = /x\=\"([^\"]+)\"/
  Y = /y\=\"([^\"]+)\"/
  WIDTH = /width\=\"([^\"]+)\"/
  HEIGHT = /height\=\"([^\"]+)\"/

  def initialize(svg)
    super
    @type = "rect"
    @attrs["x"] = svg.match(X)[1] if svg.match(X)
    @attrs["y"] = svg.match(Y)[1] if svg.match(Y)
    @attrs["width"] = svg.match(WIDTH)[1]
    @attrs["height"] = svg.match(HEIGHT)[1]
  end
end

# {"type":"circle","attr":{"cx":"45","cy":"21","r":"21"}}
class Circle < Shape
  CX = /cx\=\"([^\"]+)\"/
  CY = /cy\=\"([^\"]+)\"/
  R = /r\=\"([^\"]+)\"/

  def initialize(svg)
    super
    @type = "circle"
    @attrs["cx"] = svg.match(CX)[1]
    @attrs["cy"] = svg.match(CY)[1]
    @attrs["r"] = svg.match(R)[1]
  end
end

#<ellipse fill="#F2F2F2" cx="100" cy="117" rx="65" ry="59"/>
class Ellipse < Shape
  CX = /cx\=\"([^\"]+)\"/
  CY = /cy\=\"([^\"]+)\"/
  RX = /rx\=\"([^\"]+)\"/
  RY = /ry\=\"([^\"]+)\"/

  def initialize(svg)
    super
    @type = "ellipse"
    @attrs["cx"] = svg.match(CX)[1]
    @attrs["cy"] = svg.match(CY)[1]
    @attrs["rx"] = svg.match(RX)[1]
    @attrs["ry"] = svg.match(RY)[1]
  end
end

class Polygon < Shape
  POINTS = /points\=\"([^\"]+)\"/

  attr_accessor :POINTS

  def initialize(svg)
    super
    @type = "polygon"
    @attrs["points"] = svg.match(POINTS)[1]
  end
end




