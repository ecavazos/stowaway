require "spec/spec_helper"
require "lib/stowaway/file"
require "lib/stowaway/sweeper"
require "lib/stowaway/matcher"
require "spec/lib/io_mock.rb"

describe Stowaway::Sweeper do

  Stowaway::Output.class_eval do
    def print str;end
  end

  let(:sweeper) { Stowaway::Sweeper.new(Stowaway::Matcher.new, @ignore) }

  before(:each) do
    @ignore = [/^\.|\.rb$/]
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
    @ignore << /\.txt$/
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg")]
    sweeper.sweep("spec/data", files)
    files.length.should == 1
  end
  
  it "should print the path to the file (relative to root) being swept through" do 
    @ignore << /testfile2/
    sweeper.should_receive(:clr_print).once.with("  => /testfile1.txt")
    sweeper.sweep("spec/data", [])
  end

  it "should flush the output after sweeping through a file" do 
    @ignore << /testfile2/
    sweeper.should_receive(:flush).once
    sweeper.sweep("spec/data", [])
  end

  it "should files of the same name but with different paths as last resort" do
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg"),
             Stowaway::FileObj.new("/fake/path2/button.jpg")]
    sweeper.sweep("spec/data", files)
    files.should be_empty
  end

  it "should add a file to an array of partially matched files when matched on name only" do
    files = [Stowaway::FileObj.new("/missing/button.jpg")]
    sweeper.sweep("spec/data", files).should have(1).name_only_matches
  end

  it "should not remove files that were not found" do
    files = [Stowaway::FileObj.new("/a/stowaway.txt")]
    sweeper.sweep("spec/data", files)
    files.should_not be_empty
    files.first.fullpath.should == "/a/stowaway.txt"
  end

  it "should ignore lines with invalid encoding" do
    files = [Stowaway::FileObj.new("/fake/path1/button.jpg")]
    File.stub!(:open).and_yield(IOMock.new)
    sweeper.should_not_receive(:remove_match)
    sweeper.sweep("spec/data", files)
  end

end
