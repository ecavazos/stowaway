
require 'image_finder'

module FSHelper
  def ignore? file
    @ignore.each do |s|
      if file.match(/#{s}/i)
        return true
      end
    end
    false
  end
end

class NotFoundTracker
  include FSHelper
  
  def initialize(files_to_find)
    @files_to_find = files_to_find
    @ignore = ["^\\.", ".ico", ".png", ".gif", ".jpg"]
  end
  
  def inspect_file(file)
    File.open(file, 'r') do |i|
      while line = i.gets
        @files_to_find.each { |x| @files_to_find.delete(x) if line.include?(x) }
      end
    end
  end
  
  def scan(path)
    dir = Dir.new(path)
    
    dir.each do |f|
      next if ignore?(f)
      
      path_to_file = File.join(dir.path, f)
      
      if File.directory?(path_to_file)
        scan(path_to_file)
      else
        inspect_file(path_to_file)
      end
    end
    @files_to_find
  end
  
end

path = '/Users/Emilio/Code/sinatra/iamneato.com/'

finder = ImageFinder.new
images = finder.find path
images << 'fake.jpg'

nf = NotFoundTracker.new images
p nf.scan(path)


# 1. look for images in files
# 2. store images that are not found
# 3. output results
