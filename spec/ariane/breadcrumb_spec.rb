require 'ariane'

module Ariane
  describe Breadcrumb do
    subject { Breadcrumb.new }

    describe "#crumbs" do
      it "has a crumbs method that returns an Enumerable" do
        expect(subject.crumbs.is_a?(Enumerable)).to be_true
      end

      it "set the crumbs to an empty Enumerable by default" do
        crumbs = subject.crumbs
        expect(crumbs.respond_to?(:count)).to be_true
        expect(crumbs.count).to be(0)
      end
    end

    describe "#add" do
      it "creates a new crumb and push it to crumbs" do
        subject.add 'text', 'url', :foo => :bar
        expect(subject.crumbs.count).to be(1)
        expect(subject.crumbs.last.text).to eq 'text'
        expect(subject.crumbs.last.url).to  eq 'url'
        expect(subject.crumbs.last.data).to eq({ :foo => :bar })
      end

      it "yields passing the new crumb if a block is given" do
        subject.add 'text' do |crumb|
          crumb.url = 'url'
        end
        expect(subject.crumbs.last.url).to eq 'url'
      end
    end

    describe "#render" do
      let(:test_renderer_class) { double('renderer_clas') }
      let(:test_renderer)       { double('renderer')      }

      it "uses Ariane's default renderer if none is passed as argument" do
        Ariane.default_renderer = test_renderer
        subject.add 'text', 'url'
        expect(test_renderer).to receive(:render)
        subject.render
      end

      it "instanciates the renderer if a class is given" do
        test_renderer_class.stub(:"is_a?").with(Class).and_return(true)
        test_renderer_class.stub(:new).and_return(test_renderer)

        expect(test_renderer_class).to receive(:new)
        expect(test_renderer).to receive(:render).with([])
        Breadcrumb.new.render(test_renderer_class)
      end

      it "calls render on the renderer, passing it the cumbs" do
        subject.add 'text', 'url'
        expect(test_renderer).to receive(:render).with(subject.crumbs)
        subject.render(test_renderer)
      end
    end
  end
end
