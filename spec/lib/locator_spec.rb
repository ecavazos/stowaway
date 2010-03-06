require "spec/spec_helper"
require "lib/stowaway/file_marker"
require "lib/stowaway/locator"
require "lib/stowaway/target_context"

describe Stowaway::Locator do
  
  let(:locator) { Stowaway::Locator.new(%w{.txt}) }
  let(:context) { Stowaway::TargetContext.new("spec/data") }

  it "should be initialized with an array of file extensions to locate" do
    locator.find_all(context).length.should == 2
  end
  
  it "should return an array of FileMarker" do
    @f1 = Stowaway::FileMarker.new("spec/data/testfile1.txt")
    locator.find_all(context)[1].instance_of?(Stowaway::FileMarker).should be_true
  end
  
  it "should return all matched files" do
    @f1 = Stowaway::FileMarker.new("spec/data/testfile1.txt", "spec/data")
    @f2 = Stowaway::FileMarker.new("spec/data/testfile2.txt", "spec/data")
    locator.find_all(context).should == [@f1, @f2]
  end
  
  it "should return true when file has the correct extension" do
    locator.type?("poop.txt").should be_true
  end
  
  it "should return false when file doesn't have the correct extension" do
    locator.type?("poop.stink").should be_false
  end
  
end

