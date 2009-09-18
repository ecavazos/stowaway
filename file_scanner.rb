require 'fshelpyhelp'

class FileScanner
  include FSHelpyHelp
  
  def initialize(files_to_find)
    @files_to_find = files_to_find
    @ignore = ["^\\.", ".ico", ".png", ".gif", ".jpg"]
  end
  
  def inspect_file(file)
    File.open(file, 'r') do |i|
      while line = i.gets
        @files_to_find.each { |x| @files_to_find.delete(x) if line.include?(x) }
      end
    end
  end
  
  def scan(path)
    dir = Dir.new(path)
    
    dir.each do |f|
      next if ignore?(f)
      
      path_to_file = File.join(dir.path, f)
      
      if File.directory?(path_to_file)
        scan(path_to_file)
      else
        inspect_file(path_to_file)
      end
    end
    @files_to_find
  end

end