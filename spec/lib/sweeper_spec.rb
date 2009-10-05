require 'spec/spec_helper'
require 'lib/stowaway/file'
require 'lib/stowaway/sweeper'

describe Stowaway::Sweeper do
  
  def sweeper(ignore = nil)
    ig = ignore || [/^\./]
    @sweeper ||= Stowaway::Sweeper.new(@files, @status_mock, ig)
  end

  before(:each) do
    @f1 = Stowaway::FileObj.new('/fake/file1.jpg')
    @f2 = Stowaway::FileObj.new('/fake/file2.gif')
    @f3 = Stowaway::FileObj.new('/fake/file3.js')
    @f4 = Stowaway::FileObj.new('/fake/also/file3.js')
    @files = [@f1, @f2, @f3, @f4]
    @status_mock = mock('status_mock', :null_object => true)
  end
  
  it "should sweep through directory looking for matches" do
    sweeper.sweep('.')
    @files.should be_empty
  end
  
  it "should not sweep through ignored file types" do
    sweeper([/^\.|\.rb$|testfile1/]).sweep('spec/data').length.should == 2
  end
  
  it "should output a message when sweeping through a file" do 
    @status_mock.should_receive(:out).with("Sweeping: spec/data/testfile1.txt").once
    sweeper([/^\.|\.rb$|testfile2/]).sweep('spec/data')
  end

  it "should flush the output after sweeping through a file" do 
    @status_mock.should_receive(:flush).once
    sweeper([/^\.|\.rb$|testfile2/]).sweep('spec/data')
  end

  it "should remove matches and leave files that were not found" do
    sweeper([/^\.|\.rb$|testfile1/]).sweep('spec/data')
    @files.should == [@f1, @f2]
  end
  
end
