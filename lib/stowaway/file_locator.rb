require_relative 'fshelpyhelp'
require_relative 'file'

module Stowaway
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
        
        file = File.join(dir.path, f)
        
        if File.directory?(file) 
          find_all file, files
        elsif type?(f)
          files << FileObj.new(file)
        end
      end
      files
    end
    
  end
end