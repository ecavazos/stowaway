require_relative 'fshelpyhelp'
require_relative 'status'
require_relative "matcher"

module Stowaway
  class Sweeper
    include FSHelpyHelp

    def initialize(files_to_find, status = Status.new, ext_to_ignore = nil)
      @files_to_find = files_to_find
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
      @files_to_find
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
      @files_to_find.delete_if { |file| @matcher.match?(line, file) }
    end

  end
end
