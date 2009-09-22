require 'spec/spec_helper'
require 'lib/stowaway/file'

describe Stowaway::FileObj do
  
  before(:all) do
    @file = Stowaway::FileObj.new('/fake/path/test.rb')
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
  
  it "should be == if paths are the same" do
    @file.should == Stowaway::FileObj.new('/fake/path/test.rb')
  end
  
  it "should not be == if paths are differet" do
    @file.should_not == Stowaway::FileObj.new('/blah/test.rb')
  end
end