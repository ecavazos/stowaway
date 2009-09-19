module Stowaway
  class AFile
    def initialize(fullpath)
      @fullpath = fullpath
    end
    
    def name
      File.basename(@fullpath)
    end
    
    def path
      File.split(@fullpath)[0]
    end
  end
  
  # f = AFile.new('/Users/Emilio/Code/sinatra/iamneato.com/iamneato.rb')
  #   p f.path
end