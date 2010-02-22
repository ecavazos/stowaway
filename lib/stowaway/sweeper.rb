require_relative "fshelpyhelp"
require_relative "status"
require_relative "matcher"
require_relative "file"
require "ostruct"

module Stowaway
  class Sweeper
    include FSHelpyHelp

    def initialize(files, status = Status.new, matcher = Matcher.new, ext_to_ignore = [])
      @result = OpenStruct.new({ :files => files, :name_only_matches => []})
      @status = status
      @matcher = matcher
      @ignore = ext_to_ignore || []
      @ignore += [/^\.|\.jpg$|\.jpeg$|\.gif$|\.png$|\.ico$|\.bmp$/i]
    end

    def sweep(path)
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
      @status.out "Sweeping: #{file}"
      File.open(file, 'r') do |i|
        while line = i.gets
          remove_match(line) #rescue nil
        end
      end
      @status.flush
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
