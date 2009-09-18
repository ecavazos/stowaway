require 'fshelpyhelp'

class FileLocator
  include FSHelpyHelp
  
  def initialize(extensions)
    @extensions = extensions
    @ignore = ["^\\."]
  end
  
  def type?(file)
    @extensions.each do |e|
      return true if file.match(/#{e}$/)
    end
    false
  end
  
  def find_all(path, files = [])
    
    dir = Dir.new(path)
    
    dir.each do |f|
      next if ignore?(f)
      if File.directory?(File.join(dir.path, f)) 
        find_all File.join(dir.path, f), files
      elsif type?(f)
        files << f
      end
    end
    files
  end
  
end
