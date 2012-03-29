require 'ariane'

module Ariane
  describe Breadcrumb do
    subject { Breadcrumb.new }

    describe "#crumbs" do
      it "has a crumbs method that returns an Enumerable" do
        subject.crumbs.is_a?(Enumerable).should be_true
      end

      it "set the crumbs to an empty Enumerable by default" do
        crumbs = subject.crumbs
        crumbs.respond_to?(:count).should be_true
        crumbs.count.should be(0)
      end
    end

    describe "#add" do
      it "creates a new crumb and push it to crumbs" do
        subject.add 'text', 'url', :foo => :bar
        subject.crumbs.count.should be(1)
        subject.crumbs.last.text.should == 'text'
        subject.crumbs.last.url.should  == 'url'
        subject.crumbs.last.data.should == { :foo => :bar }
      end

      it "yields passing the new crumb if a block is given" do
        subject.add 'text' do |crumb|
          crumb.url = 'url'
        end
        subject.crumbs.last.url.should == 'url'
      end
    end

    describe "#render" do
      let(:test_renderer_class) { double('renderer_clas') }
      let(:test_renderer)       { double('renderer')      }

      it "uses Ariane's default renderer if none is passed as argument" do
        Ariane.default_renderer = test_renderer
        subject.add 'text', 'url'
        test_renderer.should_receive(:render)
        subject.render
      end

      it "instanciates the renderer if a class is given" do
        test_renderer_class.stub(:"is_a?").with(Class).and_return(true)
        test_renderer_class.stub(:new).and_return(test_renderer)

        test_renderer_class.should_receive(:new)
        test_renderer.should_receive(:render).with([])
        Breadcrumb.new.render(test_renderer_class)
      end

      it "calls render on the renderer, passing it the cumbs" do
        subject.add 'text', 'url'
        test_renderer.should_receive(:render).with(subject.crumbs)
        subject.render(test_renderer)
      end
    end
  end
end
