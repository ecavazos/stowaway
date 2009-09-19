require_relative 'spec_helper'
require_relative '../lib/stowaway/afile'

describe "AFile" do
  
  before(:all) do
    @file = Stowaway::AFile.new('/fake/path/test.rb')
  end
  
  it "should return name of file" do
    @file.name.should == 'test.rb'
  end
  
  it "should return path to file" do
    @file.path.should == '/fake/path'
  end
end