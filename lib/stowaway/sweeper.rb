require "ostruct"
require "stowaway/fshelpyhelp"
require "stowaway/output"
require "stowaway/matcher"
require "stowaway/file_marker"

module Stowaway

  # Sweeper will sweep through a directory recursively (path) and try to find
  # references to files in the array of FileObjs passed in as the second
  # parameter.

  class Sweeper
    include FSHelpyHelp
    include Output

    def initialize(matcher = Matcher.new)
      @matcher = matcher
      @ignore = [/^\.|\.jpg$|\.jpeg$|\.gif$|\.png$|\.ico$|\.bmp$/i]
    end

    def sweep(target_context, files)
      @context = target_context
      @result = OpenStruct.new({ :files => files, :name_only_matches => []})
      ignore_special_directories(@context.root)
      recursively(@context.root) { |fp| inspect_file(fp) }
      @result
    end

    private

    def inspect_file(file_p)
      clr_print("  => #{@context.path_relative_to_root(file_p)}")
      File.open(file_p, "r") do |i|
        while line = i.gets
          next unless line.valid_encoding?
          remove_match(line) #rescue nil
        end
      end
      flush
    end

    def remove_match(line)
      @result.files.delete_if do |file|
        if @matcher.match?(line, file)
          true
        elsif line.include?(file.name)
          @result.name_only_matches << file
          true
        end
      end
    end

  end
end
