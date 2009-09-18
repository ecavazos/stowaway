require 'file_locator'
require 'file_scanner'

path = '/Users/Emilio/Code/sinatra/iamneato.com/'

locator = FileLocator.new(%w{.jpg .gif .png .js .css})
images = locator.find_all path
# images << 'fake.jpg'

fs = FileScanner.new images
not_found = fs.scan(path)

if not_found.length > 0
  p not_found
else
  p 'all images appear to be in use.'
end

# 1. look for images in files
# 2. store images that are not found
# 3. output results

# 4. look for js files
# 5. look for css files
# 6. maybe exclude comments