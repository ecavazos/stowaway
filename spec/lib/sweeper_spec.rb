require 'spec/spec_helper'
require 'lib/stowaway/file'
require 'lib/stowaway/sweeper'

describe Stowaway::Sweeper do
  
  before(:each) do
    @f1 = Stowaway::FileObj.new('/fake/file1.jpg')
    @f2 = Stowaway::FileObj.new('/fake/file2.gif')
    @f3 = Stowaway::FileObj.new('/fake/file3.js')
    @files = [@f1, @f2, @f3]
    @sweeper = Stowaway::Sweeper.new(@files)
  end
  
  it "should sweep through directory structure looking for matches" do
    @sweeper.sweep('.')
    @files.should be_empty
  end
  
  it "should not examine ignored file types" do
    @sweeper = Stowaway::Sweeper.new(@files, ["^\\.", ".rb", "testfile1"])
    @sweeper.sweep('.').length.should == 2
  end

  it "should read through the file looking for matches" do
    @sweeper.inspect_file('spec/data/testfile1.txt')
    @files.should == [@f3]
  end
  
  it "should remove matches from the list of files to find" do
    line = 'file2.gif, file3.js'
    @sweeper.remove_matches line
    @files.should == [@f1]
  end
  
end