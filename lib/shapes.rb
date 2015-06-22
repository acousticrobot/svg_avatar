require 'json'

class Shape

  FILL = /fill\=\"(\#[A-Fa-f0-9]+)\"/

  attr_accessor :type, :attrs

  def initialize(svg)
    if svg.match(FILL)
      case svg.match(FILL)[1]
      when "#FFFFFF"
        class_attr = "color-bright"
      when "#999999"
        class_attr = "color-primary"
      when "#000000"
        class_attr = "color-dark"
      end
    else
       class_attr = "color-primary"
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
  D = /d\=\"(.+)\"/

  attr_accessor :d

  def initialize(svg)
    super
    @type = "path"
    @attrs["d"] = svg.match(D)[1]
  end
end

# {"type":"circle","attr":{"cx":"45","cy":"21","r":"21"}}
class Circle < Shape
  CX = /cx\=\"([\d|\.]+)\"/
  CY = /cy\=\"([\d|\.]+)\"/
  R = /r\=\"([\d|\.]+)\"/

  attr_accessor :d

  def initialize(svg)
    super
    @type = "circle"
    @attrs["cx"] = svg.match(CX)[1]
    @attrs["cy"] = svg.match(CY)[1]
    @attrs["r"] = svg.match(R)[1]
  end
end
