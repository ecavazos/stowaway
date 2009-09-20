require_relative 'fshelpyhelp'

module Stowaway
  class Sweeper
    include FSHelpyHelp
  
    def initialize(files_to_find)
      @files_to_find = files_to_find
      @ignore = ["^\\.", ".png", ".gif", ".jpg"]
    end
  
    def inspect_file(file)
      File.open(file, 'r') do |i|
        while line = i.gets
          @files_to_find.each { |x| @files_to_find.delete(x) if line.include?(x.name) }
        end
      end
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