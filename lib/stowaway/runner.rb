require_relative 'options'
require_relative 'locator'
require_relative 'sweeper'

module Stowaway
  class Runner
    
    def initialize(options, locator, sweeper)
      @options = options
      @locator = locator
      @sweeper = sweeper
    end
    
    def run
      path = @options.path
      print "\nLocating files ... "
      assets = @locator.find_all(path)
      print "#{assets.length} files located"
      blank_lines
      Dir.chdir(@options.path)
      puts "sweeping: #{Dir.pwd}"
      respond @sweeper.sweep(path, assets)
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
