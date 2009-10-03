require_relative 'options'
require_relative 'locator'
require_relative 'sweeper'

module Stowaway
  class Runner
    
    def initialize(argv)
      @options = Options.new(argv)
    end
    
    def run
      p "Locating files ..."
      locator = Stowaway::Locator.new(@options.file_types)
      files = locator.find_all @options.path
      p "#{files.size} files located"
      
      fs = Stowaway::Sweeper.new files
      respond fs.sweep @options.path
    end
    
    private
    def respond(not_found)
      if not_found.empty?
        print "Zero stowaways found. You run a tight ship.\n\n"
      else
        print "\nYou have #{not_found.length} stowaway(s)\n"
        print "--------------------------\n\n"
        not_found.each_with_index { |f, i| print "#{i+1}: #{f.fullpath}\n" }
        print "\n"
      end
    end
  end
end
