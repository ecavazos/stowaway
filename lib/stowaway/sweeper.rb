require_relative "fshelpyhelp"
require_relative "status"
require_relative "matcher"
require_relative "file"

module Stowaway
  class Sweeper
    include FSHelpyHelp

    def initialize(files_to_find, status = Status.new, ext_to_ignore = nil)
      @results = { :files_to_find => files_to_find, :name_only => []}
      @ignore = ext_to_ignore || [/^\.|\.jpg$|\.gif$|.png$|.ico$/i]
      @status = status
      @matcher = Matcher.new
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
      @results
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
      @results[:files_to_find].delete_if do |file|
        if @matcher.match?(line, file)
          true
        elsif line.include?(file.name)
          @results[:name_only] << file
          true
        end
      end
    end

  end
end
