require_relative 'spec_helper'
require_relative '../lib/stowaway/file'

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
end