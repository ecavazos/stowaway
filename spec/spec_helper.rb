require "spec"
require "spec/autorun"
require "spec/interop/test"

module Silencer
  def print str;end
  def puts str;end
  def p str;end
end

