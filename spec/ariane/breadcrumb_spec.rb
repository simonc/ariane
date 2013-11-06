require 'ariane'

module Ariane
  describe Breadcrumb do
    subject(:breadcrumb) { Breadcrumb.new }

    describe "#crumbs" do
      it "has a crumbs method that returns an Enumerable" do
        expect(breadcrumb.crumbs).to be_an(Enumerable)
      end

      it "set the crumbs to an empty Enumerable by default" do
        expect(breadcrumb.crumbs).to respond_to :count
        expect(breadcrumb.crumbs.count).to eq 0
      end
    end

    describe "#add" do
      it "creates a new crumb and push it to crumbs" do
        breadcrumb.add 'text', 'url', foo: :bar

        expect(breadcrumb.crumbs.count).to eq 1
        expect(breadcrumb.crumbs.last.text).to eq 'text'
        expect(breadcrumb.crumbs.last.url).to  eq 'url'
        expect(breadcrumb.crumbs.last.data).to eq(foo: :bar)
      end

      it "yields passing the new crumb if a block is given" do
        breadcrumb.add 'text' do |crumb|
          crumb.url = 'url'
        end

        expect(breadcrumb.crumbs.last.url).to eq 'url'
      end
    end

    describe "#render" do
      let(:test_renderer_class) { double('renderer_clas') }
      let(:test_renderer)       { double('renderer')      }

      it "uses Ariane's default renderer if none is passed as argument" do
        Ariane.default_renderer = test_renderer
        breadcrumb.add 'text', 'url'

        expect(test_renderer).to receive(:render)

        breadcrumb.render
      end

      it "instanciates the renderer if a class is given" do
        test_renderer_class.stub(:"is_a?").with(Class).and_return(true)
        test_renderer_class.stub(:new).and_return(test_renderer)

        expect(test_renderer_class).to receive(:new)
        expect(test_renderer).to receive(:render).with([])

        breadcrumb.render(test_renderer_class)
      end

      it "calls render on the renderer, passing it the cumbs" do
        breadcrumb.add 'text', 'url'

        expect(test_renderer).to receive(:render).with(breadcrumb.crumbs)

        breadcrumb.render(test_renderer)
      end
    end
  end
end
