require "stowaway/options"
require "stowaway/locator"
require "stowaway/sweeper"
require "stowaway/target_context"

module Stowaway
  class Runner

    def initialize(options, locator, sweeper)
      @options = options
      @locator = locator
      @sweeper = sweeper
    end

    #TODO: clean-up all the print and puts methods and use
    def run
      context = TargetContext.new(@options.path)
      assets = locate_assets(context)
      Dir.chdir(context.root)
      puts "sweeping: #{Dir.pwd}"
      display_results(@sweeper.sweep(context, assets))
    end

    private

    def locate_assets(context)
      print "\nLocating files ... "
      assets = @locator.find_all(context)
      print "#{assets.length} files located"
      blank_lines
      assets
    end

    def display_results(result)
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
      warn name_only_matches unless name_only_matches.empty?
      60.times { print "-" }
      blank_lines
      files.each_with_index { |f, i| print "#{i+1}: #{f.root_path}\n" }
    end

    def warn name_only_matches
        print "WARNING: #{name_only_matches.length} file(s) partially matched on name only\n"
    end

    def blank_lines
      print "\n\n"
    end
  end
end
