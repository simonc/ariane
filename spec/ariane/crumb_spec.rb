require 'ariane/crumb'

module Ariane
  describe Crumb do
    it "has a text attribute" do
      Crumb.new.respond_to?(:text).should be_true
    end

    it "sets text as an empty string by default" do
      Crumb.new.text.should == ''
    end

    it "has a setter for the text attribute" do
      crumb = Crumb.new
      crumb.text = 'test'
      crumb.text.should == 'test'
    end

    it "sets its text attribute based on the first argument of the initializer" do
      crumb = Crumb.new('test')
      crumb.text.should == 'test'
    end


    it "has an url attribute" do
      Crumb.new.respond_to?(:url).should be_true
    end

    it "sets url as nil by default" do
      Crumb.new.url.should be_nil
    end

    it "has a setter for the url attribute" do
      crumb = Crumb.new
      crumb.url = '/'
      crumb.url.should == '/'
    end

    it "sets its url attribute based on the second argument of the initializer" do
      crumb = Crumb.new('text', 'test-url')
      crumb.url.should == 'test-url'
    end


    it "has a data attribute which is a hash" do
      Crumb.new.data.should == {}
    end

    it "sets its data based on third argument of the initializer" do
      crumb = Crumb.new('text', 'url', :foo => :bar)
      crumb.data.should == { :foo => :bar }
    end
  end
end
