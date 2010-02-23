require 'optparse'

module Stowaway
  class Options
    DEFAULT_FILE_TYPES = %w{.jpg .gif .png .ico .js .css}
    
    attr_reader :path, :file_types
    
    def initialize(argv)
      @file_types = DEFAULT_FILE_TYPES
      @argv = argv
      @path = argv[0]
      parse()
    end
    
    private

    def parse
      OptionParser.new do |opts| 
        opts.banner = "Usage: stowaway [ options ] path/to/site" 
        
        opts.on("-t", "--types <TYPES>", String, "File types to search for (ex: .jpg .gif)") do |ext| 
          @file_types = ext.split(' ')
        end

        opts.on("-h", "--help", "Show this message") do
          puts opts 
          exit 
        end 
        
        begin 
          @argv = ["-h"] if @argv.empty? 
          opts.parse!(@argv) 
        rescue OptionParser::ParseError => e 
          STDERR.puts e.message, "\n", opts 
          exit(-1) 
        end 
        
      end 
    end 
  end 
end 
