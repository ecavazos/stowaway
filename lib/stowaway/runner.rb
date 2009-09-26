require_relative 'options'
require_relative 'locator'
require_relative 'sweeper'

module Stowaway
  class Runner
    
    def initialize(argv)
      @options = Options.new(argv)
    end
    
    def run
      locator = Stowaway::Locator.new(@options.file_types)
      images = locator.find_all @options.path

      fs = Stowaway::Sweeper.new images
      respond fs.sweep @options.path
    end
    
    private
    def respond(not_found)
      if not_found.empty?
        printf "Zero stowaways found. You run a tight ship.\n\n"
      else
        printf "\nYou have #{not_found.length} stowaway(s)\n"
        printf "--------------------------\n\n"
        not_found.each_with_index { |f, i| printf "#{i+1}: #{f.fullpath}\n" }
        printf "\n"
      end
    end
  end
end
