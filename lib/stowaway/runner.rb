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
      files = result.files
      name_only_matches = result.name_only_matches

      if files.empty?
        print "Zero stowaways found. "
      end

      if files.empty? and name_only_matches.empty?
        print "You run a tight ship."
        blank_lines
        return
      end
      
      damage(result)
    end
    
    def damage(result)
      files = result.files
      name_only_matches = result.name_only_matches

      print "\nYou have #{files.length} stowaway(s) ... scurvy dogs!\n"
      warn name_only_matches
      60.times { print "-" }
      blank_lines
      files.each_with_index { |f, i| print "#{i+1}: #{f.root_path}\n" }
    end

    def warn name_only_matches
        return if name_only_matches.empty?
        print "WARNING: #{name_only_matches.length} file(s) partially matched on name only\n"
    end

    def blank_lines
      print "\n\n"
    end
  end
end
