require_relative "fshelpyhelp"
require_relative "output"
require_relative "matcher"
require_relative "file"
require "ostruct"

module Stowaway

  # Sweeper will sweep through a directory recursively (path) and try to find
  # references to files in the array of FileObjs passed in as the second
  # parameter.

  class Sweeper
    include FSHelpyHelp
    include Output

    def initialize(matcher = Matcher.new, ext_to_ignore = [])
      @matcher = matcher
      @ignore = ext_to_ignore || []
      @ignore += [/^\.|\.jpg$|\.jpeg$|\.gif$|\.png$|\.ico$|\.bmp$/i]
    end

    def sweep(path, files=nil)
      @result ||= OpenStruct.new({ :files => files, :name_only_matches => []})

      dir = Dir.new(path)

      dir.each do |f|
        next if ignore?(f)

        file = File.join(dir.path, f)

        if File.directory?(file)
          sweep(file)
        else
          inspect_file(file)
        end
      end
      @result
    end

    private

    def inspect_file(file)
      clr_print("Sweeping: #{file}")
      File.open(file, 'r') do |i|
        while line = i.gets
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
