require_relative 'fshelpyhelp'
require_relative 'file'

module Stowaway
  class Locator
    include FSHelpyHelp

    def initialize(extensions)
      @extensions = extensions
      @ignore = [/^\./]
    end

    def find_all(path, files = [])
      @root = path if @root.nil?

      dir = Dir.new(path)

      dir.each do |f|
        next if ignore?(f)

        file = File.join(dir.path, f)

        if File.directory?(file) 
          find_all file, files
        elsif type?(f)
          files << FileObj.new(file, @root)
        end
      end
      files
    end

    def type?(file)
      @extensions.each do |e|
        return true if file.match(/#{e}$/)
      end
      false
    end
  end
end
