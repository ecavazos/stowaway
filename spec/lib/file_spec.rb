require "spec/spec_helper"
require "lib/stowaway/file_marker"

describe Stowaway::FileMarker do
  before(:all) do
    @file = Stowaway::FileMarker.new('/fake/path/test.rb')
  end
  
  it "should return full path" do
    @file.fullpath.should == '/fake/path/test.rb'
  end
  
  it "should return name of file" do
    @file.name.should == 'test.rb'
  end
  
  it "should return path to file" do
    @file.path.should == '/fake/path'
  end
  
  it "should be equal if paths are the same" do
    @file.should == Stowaway::FileMarker.new('/fake/path/test.rb')
  end
  
  it "should not be equal if paths are different" do
    @file.should_not == Stowaway::FileMarker.new('/blah/test.rb')
  end
end
