require 'spec/spec_helper'
require 'lib/stowaway/runner'

class Stowaway::Status
  # mock so I don't look at noise
  def out(msg); end
  def flush; end
end

class Stowaway::Runner
  def print str;end
  def puts str;end
end


describe Stowaway::Runner do

  before(:each) do
    @argv = ["."]
    @options = Stowaway::Options.new(@argv)
    @locator = Stowaway::Locator.new(@options.file_types)
  end

  def runner
    sweeper = Stowaway::Sweeper.new
    @runner ||= Stowaway::Runner.new(@options, @locator, sweeper)
  end

  describe "output" do
    it "should notify user that file location has begun" do
      runner.should_receive(:print).with("\nLocating files ... ")
      runner.should_receive(:print).any_number_of_times
      runner.run
    end

    it "should notify user of the total number of files that were found" do
      runner.should_receive(:print).with("0 files located")
      runner.should_receive(:print).any_number_of_times
      runner.run
    end

    it "should notify user that no stowaways were found when all files-to-find have been deleted" do
      runner.should_receive(:print).with("Zero stowaways found. ")
      runner.should_receive(:print).any_number_of_times
      runner.run
    end

    it "should tell user how awesome their cleanliness is" do
      runner.should_receive(:print).with("You run a tight ship.")
      runner.should_receive(:print).any_number_of_times
      runner.run
    end
  end

  it "should locate all assets" do
    @locator.should_receive(:find_all).with(".").and_return([])
    runner.run
  end
end
