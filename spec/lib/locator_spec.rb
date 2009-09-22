require 'spec/spec_helper'
require 'lib/stowaway/file'
require 'lib/stowaway/locator'

describe Stowaway::Locator do
  
  def locator
    @locator ||= Stowaway::Locator.new(%w{.txt})
  end
  
  it "should be initialized with an array of file extensions to locate" do
    locator.find_all('.').length.should == 2
  end
  
  it "should return an array of FileObj" do
    @f1 = Stowaway::FileObj.new('./spec/data/testfile1.txt')
    locator.find_all('.')[1].instance_of?(Stowaway::FileObj).should be_true
  end
  
  it "should return all matched files" do
    @f1 = Stowaway::FileObj.new('./spec/data/testfile1.txt')
    @f2 = Stowaway::FileObj.new('./spec/data/testfile2.txt')
    locator.find_all('.').should == [@f1, @f2]
  end
  
  it "should return true when file has the correct extension" do
    locator.type?('poop.txt').should be_true
  end
  
  it "should return false when file doesn't have the correct extension" do
    locator.type?('poop.stink').should be_false
  end
  
end 