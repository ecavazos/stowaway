require "spec/spec_helper"
require "lib/stowaway/file"
require "lib/stowaway/sweeper"
require "lib/stowaway/matcher"

describe Stowaway::Sweeper do
  
  def sweeper(ignore = nil)
    @sweeper ||= Stowaway::Sweeper.new(@files, @status_mock, Stowaway::Matcher.new, ignore)
  end

  before(:each) do
    @files = []
    @status_mock = mock("status_mock", :null_object => true)
  end
  
  it "should remove files when a reference to the file is found in source" do
    @files << Stowaway::FileObj.new("/fake/path1/button.jpg")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end

  it "should not sweep through ignored file types" do
    @files << Stowaway::FileObj.new("/fake/path1/button.jpg")
    sweeper([/^\.|\.rb$|\.txt$/]).sweep("spec/data")
    @files.length.should == 1
  end
  
  it "should output a message when sweeping through a file" do 
    @status_mock.should_receive(:out).with("Sweeping: spec/data/testfile1.txt").once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
  end

  it "should flush the output after sweeping through a file" do 
    @status_mock.should_receive(:flush).once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
  end

  it "should files of the same name but with different paths as last resort" do
    @files << Stowaway::FileObj.new("/fake/path1/button.jpg")
    @files << Stowaway::FileObj.new("/fake/path2/button.jpg")
    sweeper([/^\.|\.rb$/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should add a file matched on name only to an array of partially matched files" do
    @files << Stowaway::FileObj.new("/missing/button.jpg")
    sweeper([/^\.|\.rb$/]).sweep("spec/data").should have(1)[:name_only_matches]
  end

  it "should not remove files that were not found" do
    @files << Stowaway::FileObj.new("/a/stowaway.txt")
    sweeper([/^\.|\.rb$/]).sweep("spec/data")
    @files.should_not be_empty
    @files.first.fullpath.should == "/a/stowaway.txt"
  end
  
end
