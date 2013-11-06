require 'ariane/levelcrumb'

module Ariane
  describe LevelCrumb do
    subject { LevelCrumb.new }

    describe ".new" do
      subject(:crumb) { LevelCrumb.new('text', 'url', 1, foo: :bar) }

      it "sets its text attribute based on the first argument of the initializer" do
        expect(crumb.text).to eq 'text'
      end

      it "sets its url attribute based on the second argument of the initializer" do
        expect(crumb.url).to eq 'url'
      end

      it "sets its level based on third argument of the initializer" do
        expect(crumb.level).to eq 1
      end

      it "sets its data based on fourth argument of the initializer" do
        expect(crumb.data).to eq(foo: :bar)
      end
    end

    describe "#text" do
      it "sets text as an empty string by default" do
        expect(subject.text).to eq ''
      end

      it "has a setter for the text attribute" do
        subject.text = 'test'
        expect(subject.text).to eq 'test'
      end
    end

    describe "#url" do
      it "sets url as nil by default" do
        expect(subject.url).to be_nil
      end

      it "has a setter for the url attribute" do
        subject.url = '/'
        expect(subject.url).to eq '/'
      end
    end

    describe "#data" do
      it "has a data attribute which is a hash" do
        expect(subject.data).to eq({})
      end
    end
  end
end
