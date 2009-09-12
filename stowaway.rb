require 'FileUtils'

class ImageFinder
  
  def ignore?(file)
    %w{. .. .git .sass-cache}.include?(file)
  end
  
  def image?(file)
    exts = %w{jpg gif png}
    exts.each do |e|
      return true if file.match(/#{e}$/)
    end
    false
  end
  
  def find(path, images = [])
    
    dir = Dir.new(path)
    
    dir.each do |f|
      next if ignore?(f)
      if File.directory?(File.join(dir.path, f))  
        find File.join(dir.path, f), images
      elsif image?(f)
        images << File.join(dir.path, f)
      end
    end
    images
  end
  
end

finder = ImageFinder.new
p finder.find '/Users/Emilio/Code/sinatra/iamneato.com/'

# 1. look for images in files
# 2. store images that are not found
# 3. output results
