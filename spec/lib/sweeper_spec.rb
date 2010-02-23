require "spec/spec_helper"
require "lib/stowaway/file"
require "lib/stowaway/sweeper"
require "lib/stowaway/matcher"

describe Stowaway::Sweeper do
  
  def sweeper(ignore = nil)
    @sweeper ||= Stowaway::Sweeper.new(@status_mock, Stowaway::Matcher.new, ignore)
  end

  before(:each) do
    @status_mock = mock("status_mock", :null_object => true)
  end
  
  it "should remove files when a reference to the file is found in source" do
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg")]
    sweeper.sweep("spec/data", files)
    files.should be_empty
  end

  it "should return an OpenStruct with the result of the sweeping" do
    result = sweeper.sweep("spec/data", [])
    result.files.should be_an_instance_of Array
    result.name_only_matches.should be_an_instance_of Array
  end

  it "should not sweep through ignored file types" do
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg")]
    sweeper([/^\.|\.rb$|\.txt$/]).sweep("spec/data", files)
    files.length.should == 1
  end
  
  it "should output a message when sweeping through a file" do 
    @status_mock.should_receive(:out).with("Sweeping: spec/data/testfile1.txt").once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data", [])
  end

  it "should flush the output after sweeping through a file" do 
    @status_mock.should_receive(:flush).once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data", [])
  end

  it "should files of the same name but with different paths as last resort" do
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg"),
             Stowaway::FileObj.new("/fake/path2/button.jpg")]
    sweeper([/^\.|\.rb$/]).sweep("spec/data", files)
    files.should be_empty
  end

  it "should add a file to an array of partially matched files when matched on name only" do
    files = [Stowaway::FileObj.new("/missing/button.jpg")]
    sweeper([/^\.|\.rb$/]).sweep("spec/data", files).should have(1).name_only_matches
  end

  it "should not remove files that were not found" do
    files = [Stowaway::FileObj.new("/a/stowaway.txt")]
    sweeper([/^\.|\.rb$/]).sweep("spec/data", files)
    files.should_not be_empty
    files.first.fullpath.should == "/a/stowaway.txt"
  end
  
end
