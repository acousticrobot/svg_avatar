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
end
