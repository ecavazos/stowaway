require "spec/spec_helper"
require "lib/stowaway/target_context"

describe Stowaway::TargetContext do
  
  let(:context) do
    Stowaway::TargetContext.new(@root)
  end

  before(:each) do
    @root = "/fake/path/to/root/"
  end

  it "should return the path the object was intialized with" do
    context.root.should == @root
  end

  it "should transform path to be relative to the root directory" do
    file_p = @root + "public/images/monkey_skull.gif"
    context.path_relative_to_root(file_p).should == "/public/images/monkey_skull.gif"
  end
end
