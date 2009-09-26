require 'spec/spec_helper'
require 'lib/stowaway/options'

describe Stowaway::Options do
  
  it "should use the the default file types when none are provided" do
    opts = Stowaway::Options.new(['fake/path'])
    Stowaway::Options::DEFAULT_FILE_TYPES.should == %w{.jpg .gif .png .ico .js .css}
  end
  
  it "should use the file types provided by user" do
    opts = Stowaway::Options.new(['-t', '.png .jpg', 'fake/path'])
    opts.file_types.should == %w{.png .jpg}
  end
  
  it "should parse path provided by user when file types are provided" do
    opts = Stowaway::Options.new(['-t', '.png .jpg', 'fake/path'])
    opts.path.should == 'fake/path'
  end
  
  it "should parse path provided by user when no file types are provided" do
    opts = Stowaway::Options.new(['fake/path'])
    opts.path.should == 'fake/path'
  end
end
