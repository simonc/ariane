require 'ariane/crumb'

module Ariane
  describe Crumb do
    it "has a text attribute" do
      Crumb.new.respond_to?(:text)
    end

    it "sets text as an empty string by default" do
      Crumb.new.text.should == ''
    end

    it "has a setter for the text attribute" do
      crumb = Crumb.new
      crumb.text = 'test'
      crumb.text.should == 'test'
    end


    it "has an url attribute" do
      Crumb.new.respond_to?(:url)
    end

    it "sets url as nil by default" do
      Crumb.new.url.should be_nil
    end

    it "has a setter for the url attribute" do
      crumb = Crumb.new
      crumb.url = '/'
      crumb.url.should == '/'
    end
  end
end
