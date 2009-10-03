require_relative 'fshelpyhelp'

module Stowaway
  class Sweeper
    include FSHelpyHelp

    def initialize(files_to_find, ext_to_ignore = nil)
      @files_to_find = files_to_find
      @ignore = ext_to_ignore || [/^\.|\.jpg$|\.gif$|.png$/i]
    end
  
    def inspect_file(file)
      reset = "\r\e[0K"
      print "#{reset}Sweeping: #{file}"
      File.open(file, 'r') do |i|
        while line = i.gets
          remove_match(line)
        end
      end
      sleep(0.12)
      print reset
      $stdout.flush
    end

    def remove_match(line)
      @files_to_find.delete_if { |file| line.include?(file.name) }
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

  end
end
