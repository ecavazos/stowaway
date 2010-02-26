require 'spec/spec_helper'
require 'lib/stowaway/output'

describe Stowaway::Output do

  before(:each) do
    @klass = Class.new do
      include Stowaway::Output
    end.new
  end

  describe "clr_print" do
    it "should reset current line and print message" do
      reset = "\r\e[0K"
      msg = "yo yo sucka beeches!"
      @klass.should_receive(:print).once.with("#{reset}#{msg}")
      @klass.clr_print(msg)
    end
  end

  describe "flush" do
    it "should reset current line" do
      @klass.should_receive(:print).once.with("\r\e[0K")
      @klass.flush
    end

    it "should call flush on stdout" do
      $stdout.should_receive(:flush)
      @klass.flush
    end
  end

  describe "new_line" do
    it "should print 1 new line" do
      @klass.should_receive(:print).once.with("\n")
      @klass.new_line
    end

    it "should print 2 new lines" do
      @klass.should_receive(:print).twice.with("\n")
      @klass.new_line(2)
    end

    it "should print 8 new lines" do
      @klass.should_receive(:print).exactly(8).times.with("\n")
      @klass.new_line(8)
    end
  end

end
