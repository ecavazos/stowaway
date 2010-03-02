require_relative 'fshelpyhelp'
require_relative 'file'

module Stowaway
  class Locator
    include FSHelpyHelp

    def initialize(extensions)
      @extensions = extensions
      @ignore = [/^\./]
    end

    def find_all(path)
      @root = path
      @files = []
      ignore_special_directories(@root)
      recursively(path) do |file_p|
        push_if_ext_match(file_p)
      end
      @files
    end

    def push_if_ext_match(file_p)
      @files << FileObj.new(file_p, @root) if type?(file_p)
    end

    def type?(file)
      @extensions.each do |e|
        return true if file.match(/#{e}$/)
      end
      false
    end
  end
end
