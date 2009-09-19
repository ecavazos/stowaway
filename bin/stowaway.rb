require '../lib/stowaway/file_locator'
require '../lib/stowaway/sweeper'

path = '/Users/Emilio/Code/sinatra/iamneato.com/'
types = %w{.jpg .gif .png .ico .js .css}
locator = Stowaway::FileLocator.new(types)
images = locator.find_all path

fs = Stowaway::Sweeper.new images
not_found = fs.sweep(path)

if not_found.length > 0
  p "You have #{not_found.length} stowaway(s)"
  p "----------------------------"
  p ""
  not_found.each { |f| p "file: #{f}"  }
else
  p 'all images appear to be in use.'
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