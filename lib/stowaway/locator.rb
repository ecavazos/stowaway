require_relative "fshelpyhelp"
require_relative "file_marker"

module Stowaway
  class Locator
    include FSHelpyHelp

    def initialize(extensions)
      @extensions = extensions
      @ignore = [/^\./]
    end

    def find_all(target_context)
      @context = target_context
      @files = []
      ignore_special_directories(@context.root)
      recursively(@context.root) do |file_p|
        push_if_ext_match(file_p)
      end
      @files
    end

    def push_if_ext_match(file_p)
      @files << FileMarker.new(file_p, @context.root) if type?(file_p)
    end

    def type?(file)
      @extensions.each do |e|
        return true if file.match(/#{e}$/)
      end
      false
    end
  end
end
