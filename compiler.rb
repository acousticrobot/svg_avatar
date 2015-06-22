#!/usr/bin/env ruby
require 'pry'
require './lib/group.rb'
require './lib/shapes.rb'
require './lib/index.rb'
require './lib/reader_writer.rb'

SHAPES = /path|circle/

rw = ReaderWriter.new

@index = Index.new()

# each file
file = "svg/faces/slaxsus.svg"
title = File.basename(file, ".*")
contents = rw.read_to_array file

@group = Group.new(title)
@index.add_group @group

contents.each do |line|
  next if line == "\n"
  if line.match(SHAPES)
    case line.match(SHAPES)[0]
    when "path"
      @shape = Path.new(line)
    when "circle"
      @shape = Circle.new(line)
    else
      @shape = Shape.new(line)
    end
    @group.add_shape(@shape)
  end
end

@index.save(rw)
