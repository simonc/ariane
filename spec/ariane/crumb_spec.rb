require 'ariane/crumb'

module Ariane
  describe Crumb do
    subject { Crumb.new }

    describe ".new" do
      it "sets its text attribute based on the first argument of the initializer" do
        crumb = Crumb.new('test')
        crumb.text.should == 'test'
      end

      it "sets its url attribute based on the second argument of the initializer" do
        crumb = Crumb.new('text', 'test-url')
        crumb.url.should == 'test-url'
      end

      it "sets its data based on third argument of the initializer" do
        crumb = Crumb.new('text', 'url', 1)
        crumb.level.should == 1
      end

      it "sets its data based on fourth argument of the initializer" do
        crumb = Crumb.new('text', 'url', 1, :foo => :bar)
        crumb.data.should == { :foo => :bar }
      end
    end

    describe "#text" do
      it "sets text as an empty string by default" do
        subject.text.should == ''
      end

      it "has a setter for the text attribute" do
        subject.text = 'test'
        subject.text.should == 'test'
      end
    end

    describe "#url" do
      it "sets url as nil by default" do
        subject.url.should be_nil
      end

      it "has a setter for the url attribute" do
        subject.url = '/'
        subject.url.should == '/'
      end
    end

    describe "#data" do
      it "has a data attribute which is a hash" do
        subject.data.should == {}
      end
    end
  end
end
