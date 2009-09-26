require_relative 'stowaway/options'
require_relative 'stowaway/locator'
require_relative 'stowaway/sweeper'

module Stowaway
  class Runner
    
    def initialize(argv)
      @options = Options.new(argv)
    end
    
    def run
      #dir_to_search = '/Users/Emilio/Code/sinatra/iamneato.com/'
      #types = %w{.jpg .gif .png .ico .js .css}

      locator = Stowaway::Locator.new(@options.file_types)
      images = locator.find_all @options.path

      fs = Stowaway::Sweeper.new images
      not_found = fs.sweep @options.path

      if not_found.length > 0
        printf "\nYou have #{not_found.length} stowaway(s)\n"
        printf "--------------------------\n\n"
        not_found.each_with_index { |f, i| printf "#{i+1}: #{f.fullpath}\n" }
        printf "\n"
      else
        printf "Zero stowaways found. You run a tight ship.\n\n"
      end
    end
    
  end
end

# 1. look for references in files (only text files)
# 2. store images that are not found
# 3. output results
# 4. look for js files
# 5. look for css files
# 6. maybe exclude comments

# TODO: 
# 1. match files on path+name in order to retain uniqueness
# 2. output path+name