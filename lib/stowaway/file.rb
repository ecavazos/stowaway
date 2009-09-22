module Stowaway
  class FileObj
    attr :fullpath
    
    def initialize(fullpath)
      @fullpath = fullpath
    end
    
    def name
      File.basename(@fullpath)
    end
    
    def path
      File.split(@fullpath)[0]
    end
    
    def ==(fileObj)
      self.fullpath == fileObj.fullpath
    end
  end
end