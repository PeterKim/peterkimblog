require 'spec_helper'

describe ApplicationHelper do
  describe "full_title" do
    it "should include the page title" do
      full_title("foo").should =~ /foo/
    end
    it "should include the base title" do
      full_title("foo").should =~ /^peterkimblog/
    end
    it "should include the bar" do
      full_title("foo").should =~ /\|/
    end   
  end
end
