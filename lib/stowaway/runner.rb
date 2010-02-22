require_relative 'options'
require_relative 'locator'
require_relative 'sweeper'

module Stowaway
  class Runner
    
    def initialize(argv)
      @options = Options.new(argv)
    end
    
    def run
      print "\nLocating files ... "
      locator = Stowaway::Locator.new(@options.file_types)
      files = locator.find_all @options.path
      @total = files.length
      p "#{@total} files located"
      
      fs = Stowaway::Sweeper.new files
      respond fs.sweep @options.path
    end
    
    private

    def respond(result)
      if result.files.empty?
        print "Zero stowaways found. You run a tight ship.\n\n"
      else
        print "\nYou have #{result.files.length} stowaway(s) ... shameful\n\n"

        unless result.name_only_matches.empty?
          p "Warning: #{result.name_only_matches.length} file(s) partially matched on name only"
        end

        60.times { print "-" }
        print "\n\n"
        result.files.each_with_index { |f, i| print "#{i+1}: #{f.root_path}\n" }
        print "\n"
      end
    end
  end
end
