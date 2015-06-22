#!/usr/bin/env ruby
require 'pry'
require './lib/group.rb'
require './lib/shapes.rb'
require './lib/index.rb'
require './lib/parser.rb'


DIR = "./svg"


@parser = Parser.new(DIR)
@parser.parse
@parser.export


