require "spec/spec_helper"
require "lib/stowaway/file"
require "lib/stowaway/sweeper"

describe Stowaway::Sweeper do
  
  def sweeper(ignore = nil)
    ig = ignore || [/^\./]
    @sweeper ||= Stowaway::Sweeper.new(@files, @status_mock, ig)
  end

  before(:each) do
    @files = []
    @status_mock = mock("status_mock", :null_object => true)
  end
  
  it "should match images referenced in a src attribute" do
    @files << Stowaway::FileObj.new("/fake/path1/button.jpg")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end
  
  it "should match images referenced in an href attribute" do
    @files << Stowaway::FileObj.new("/fake/path/photo.jpg")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end

  it "should match images referenced in an href attribute when using haml" do
    @files << Stowaway::FileObj.new("/images/haml.jpg")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end

  it "should match images referenced in a src attribute when using haml" do
    @files << Stowaway::FileObj.new("/images/file.jpg")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end

  it "should match scripts referenced in a src attribute" do
    @files << Stowaway::FileObj.new("/fake/path/file.js")
    sweeper.sweep("spec/data")
    @files.should be_empty
  end

  it "should match scripts referenced in a rails javascript_include_tag helper" do
    @files << Stowaway::FileObj.new("/public/javascripts/file.js")
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should match scripts referenced in a rails javascript_include_tag helper when no extension is given" do
    @files << Stowaway::FileObj.new("/public/javascripts/application.js")
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should match multiple scripts referenced in a rails javascript_include_tag helper" do
    @files << Stowaway::FileObj.new("/public/javascripts/jquery.js")
    @files << Stowaway::FileObj.new("/public/javascripts/home/index.js")
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should match css files referenced in a rails stylesheet_link_tag helper" do
    @files << Stowaway::FileObj.new("/public/stylesheets/file.css")
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should match multiple css files referenced in a rails stylesheet_link_tag helper" do
    @files << Stowaway::FileObj.new("/public/stylesheets/reset.css")
    @files << Stowaway::FileObj.new("/public/stylesheets/common.css")
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should not sweep through ignored file types" do
    @files << Stowaway::FileObj.new("/public/stylesheets/reset.css")
    sweeper([/^\.|\.rb$|testfile1/]).sweep("spec/data").length.should == 1
  end
  
  it "should output a message when sweeping through a file" do 
    @status_mock.should_receive(:out).with("Sweeping: spec/data/testfile1.txt").once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
  end

  it "should flush the output after sweeping through a file" do 
    @status_mock.should_receive(:flush).once
    sweeper([/^\.|\.rb$|testfile2/]).sweep("spec/data")
  end

  it "should find images of the same name but with different paths" do
    @files << Stowaway::FileObj.new("/fake/path1/button.jpg")
    @files << Stowaway::FileObj.new("/fake/path2/button.jpg")
    sweeper([/^\.|\.rb$/]).sweep("spec/data")
    @files.should be_empty
  end

  it "should remove matches and leave files that were not found" do
    @files << Stowaway::FileObj.new("/a/stowaway/file.txt")
    sweeper([/^\.|\.rb$/]).sweep("spec/data")
    @files.should_not be_empty
    @files.first.fullpath.should == "/a/stowaway/file.txt"
  end
  
end
