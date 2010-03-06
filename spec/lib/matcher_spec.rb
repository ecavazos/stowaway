require "spec/spec_helper"
require "lib/stowaway/file_marker"
require "lib/stowaway/matcher"

describe Stowaway::Matcher do

  before do
    @matcher = Stowaway::Matcher.new
  end

  describe "when given html" do
    it "should match files referenced from a src attribute" do
      line = "test html: <img src='/images/foo.jpg' />"
      file = Stowaway::FileMarker.new("/images/foo.jpg")
      @matcher.match?(line, file).should be_true
    end

    it "should match files stored in /public referenced from a src attribute" do
      line = "test html: <img src='/images/foo.jpg' />"
      file = Stowaway::FileMarker.new("/public/images/foo.jpg")
      @matcher.match?(line, file).should be_true
    end

    it "should match files referenced from an href attribute" do
      line = "test html: <a href='/images/foo.gif'>bar</a>"
      file = Stowaway::FileMarker.new("/images/foo.gif")
      @matcher.match?(line, file).should be_true
    end

    it "should match files stored in /public referenced from an href attribute" do
      line = "test html: <a href='/images/foo.gif'>bar</a>"
      file = Stowaway::FileMarker.new("/public/images/foo.gif")
      @matcher.match?(line, file).should be_true
    end
  end

  describe "when given haml" do
    it "should match files referenced from a src attribute" do
      line = "test haml: %img{ :src => '/images/foo.jpg', :alt => 'foo' }"
      file = Stowaway::FileMarker.new("/images/foo.jpg")
      @matcher.match?(line, file).should be_true
    end

    it "should match files stored in /public referenced from a src attribute" do
      line = "test haml: %img{ :src => '/images/foo.jpg', :alt => 'foo' }"
      file = Stowaway::FileMarker.new("/public/images/foo.jpg")
      @matcher.match?(line, file).should be_true
    end

    it "should match files referenced from an href attribute" do
      line = "%link{:href => '/styles/reset.css', :type => 'text/css'}"
      file = Stowaway::FileMarker.new("/styles/reset.css")
      @matcher.match?(line, file).should be_true
    end

    it "should match files stored in /public referenced from a href attribute" do
      line = "%link{:href => '/styles/reset.css', :type => 'text/css'}"
      file = Stowaway::FileMarker.new("/public/styles/reset.css")
      @matcher.match?(line, file).should be_true
    end
  end

  describe "when given javascript_include_tag" do
    it "should match files referenced" do
      line = "test rails: %=javascript_include_tag 'foo.js'"
      file = Stowaway::FileMarker.new("/public/javascripts/foo.js")
      @matcher.match?(line, file).should be_true
    end

    it "should match files referenced with multiple arguments" do
      line = "test rails: =javascript_include_tag 'foo.js', 'test/bar.js'"
      file = Stowaway::FileMarker.new("/public/javascripts/test/bar.js")
      @matcher.match?(line, file).should be_true
    end
  end

  describe "when given stylesheet_link_tag" do
    it "should match files referenced" do
      line = "test rails: %=stylesheet_link_tag 'foo.css'"
      file = Stowaway::FileMarker.new("/public/stylesheets/foo.css")
      @matcher.match?(line, file).should be_true
    end

    it "should match files referenced" do
      line = "test rails: %=stylesheet_link_tag 'foo.css', 'to/file/bar.css'"
      file = Stowaway::FileMarker.new("/public/stylesheets/to/file/bar.css")
      @matcher.match?(line, file).should be_true
    end

    describe "when given css" do
      it "should match files referenced in url()" do
        line = "background: url('/images/foo.png') no-repeat"
        file = Stowaway::FileMarker.new("/images/foo.png")
        @matcher.match?(line, file).should be_true
      end

      it "should match files stored in /public referenced in url()" do
        line = "background: url(\"/images/foo.png\") no-repeat"
        file = Stowaway::FileMarker.new("/public/images/foo.png")
        @matcher.match?(line, file).should be_true
      end

      it "should match files referenced in url() without quotes" do
        line = "background: url(/images/foo.png) no-repeat"
        file = Stowaway::FileMarker.new("/images/foo.png")
        @matcher.match?(line, file).should be_true
      end
    end
  end
  
end
