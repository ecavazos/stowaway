module Stowaway
  class FileMarker
    attr :fullpath

    def initialize(fullpath, root = nil)
      @fullpath = fullpath
      @root = root || Dir.pwd
    end

    def name
      File.basename(@fullpath)
    end

    def path
      File.split(@fullpath)[0]
    end

    def root_path
      root = @root.split("/").last
      @fullpath.sub(/^.+\/#{root}/, "")
    end

    def ==(fileObj)
      self.fullpath == fileObj.fullpath
    end
  end
end

