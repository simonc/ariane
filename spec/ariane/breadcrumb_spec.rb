require 'ariane'

module Ariane
  describe Breadcrumb do
    describe "#crumbs" do
      it "has a crumbs method that returns an Enumerable" do
        Breadcrumb.new.crumbs.is_a?(Enumerable).should be_true
      end

      it "set the crumbs to an empty Enumerable by default" do
        crumbs = Breadcrumb.new.crumbs
        crumbs.respond_to?(:count).should be_true
        crumbs.count.should be(0)
      end
    end

    describe "#add" do
      it "creates a new crumb and push it to crumbs" do
        breadcrumb = Breadcrumb.new
        breadcrumb.add 'text', 'url', :foo => :bar
        breadcrumb.crumbs.count.should be(1)
        breadcrumb.crumbs.last.text.should == 'text'
        breadcrumb.crumbs.last.url.should  == 'url'
        breadcrumb.crumbs.last.data.should == { :foo => :bar }
      end

      it "yields passing the new crumb if a block is given" do
        breadcrumb = Breadcrumb.new
        breadcrumb.add 'text' do |crumb|
          crumb.url = 'url'
        end
        breadcrumb.crumbs.last.url.should == 'url'
      end
    end

    describe "#render" do
      let(:test_renderer_class) { double('renderer_clas') }
      let(:test_renderer)       { double('renderer')      }

      it "uses Ariane's default renderer if none is passed as argument" do
        Ariane.default_renderer = test_renderer
        breadcrumb = Breadcrumb.new
        breadcrumb.add 'text', 'url'
        test_renderer.should_receive(:render)
        breadcrumb.render
      end

      it "instanciates the renderer if a class is given" do
        test_renderer_class.stub(:"is_a?").with(Class).and_return(true)
        test_renderer_class.stub(:new).and_return(test_renderer)

        test_renderer_class.should_receive(:new)
        test_renderer.should_receive(:render).with([])
        Breadcrumb.new.render(test_renderer_class)
      end

      it "calls render on the renderer, passing it the cumbs" do
        breadcrumb = Breadcrumb.new
        breadcrumb.add 'text', 'url'
        test_renderer.should_receive(:render).with(breadcrumb.crumbs)
        breadcrumb.render(test_renderer)
      end
    end
  end
end
