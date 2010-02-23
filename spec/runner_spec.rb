require 'spec/spec_helper'
require 'lib/stowaway/runner'

describe Stowaway::Runner do

  before(:each) do
    @argv = []
  end

  def runner
    @runner ||= Stowaway::Runner.new(@argv)
  end

  it "should notify user that file location has begun" do
    @argv << "."
    runner.should_receive(:print).with("\nLocating files ... ")
    runner.should_receive(:print).any_number_of_times
    runner.run
  end

  it "should notify user of the total number of files that were found" do
    @argv << "."
    runner.should_receive(:print).with("0 files located\n").any_number_of_times
    runner.should_receive(:print).any_number_of_times
    runner.run
  end
end
