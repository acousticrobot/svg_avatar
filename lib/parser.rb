class ReaderWriter

  def write_to_file(filename, content)
    File.open( filename,"w" ) do |f|
      f.write(content)
    end
  end

  def read_to_array(filename)
    contents = []
    File.open( filename, "r" ) do |f|
      f.each_line do |line|
        contents << line
      end
    end
    contents
  end

  def read_files_to_array(dir)
    Dir.entries(dir).select {|f| !File.directory?(f) && File.fnmatch('**.svg', f)}
  end

  def read_dirs_to_array(dir)
    a = []
    dirs = Pathname.new(dir).children.select { |c| c.directory? }
    dirs.each do |dir|
      a << dir.basename.to_s
    end
    a
  end
end

class Parser
  attr_reader :dir, :components, :reader_writer, :index
  SHAPES = /(path|circle|ellipse|polygon|rect)/

  def initialize(dir)
    @dir = dir
    @reader_writer = ReaderWriter.new
    @index = Index.new()
    @components = @reader_writer.read_dirs_to_array dir
  end

  def index_file(file, component)
    title = File.basename(file, ".*")
    file = File.join(@dir,component,file)
    contents = @reader_writer.read_to_array file
    @group = Group.new(title)
    @index.add_group @group, component

    puts "  now building #{title}..."
    contents.each do |line|
      next if line == "\n"
      if line.match(SHAPES)
        case line.match(SHAPES)[1]
        when "path"
          @shape = Path.new(line)
        when "circle"
          @shape = Circle.new(line)
        when "ellipse"
          @shape = Ellipse.new(line)
        when "polygon"
          @shape = Polygon.new(line)
        when "rect"
          @shape = Rect.new(line)
        else
          @shape = Shape.new(line)
        end
        @group.add_shape(@shape)
      end
    end
  end

  def parse
    components.each do |component|
      puts "now working on #{component} files..."
      @index.add_component(component)
      component_dir = File.join(@dir,component)
      files = @reader_writer.read_files_to_array(component_dir)
      files.each do |file|
        index_file file, component
      end
    end
  end

  def export
    @index.save(@reader_writer)
  end
end
