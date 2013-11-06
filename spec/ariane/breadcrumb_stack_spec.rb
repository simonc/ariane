require 'ariane'

module Ariane
  describe BreadcrumbStack do
    subject { BreadcrumbStack.new }

    before :each do
      subject.clear
    end

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
      it "creates a new crumb and pushes it to crumbs" do
        subject.add 'text', 'url', 1, :foo => :bar
        expect(subject.crumbs.count).to be(1)
        expect(subject.crumbs.last.text).to eq 'text'
        expect(subject.crumbs.last.url).to  eq 'url'
        expect(subject.crumbs.last.data).to eq({:foo => :bar })
      end

      it "yields passing the new crumb if a block is given" do
        subject.add 'text' do |crumb|
          crumb.url = 'url'
        end
        expect(subject.crumbs.last.url).to eq 'url'
      end

      it "places a new crumb on the stack if the level is higher than the last" do
        subject.add "home", "/", 1
        subject.add "things", "/things", 2
        expect(subject.crumbs.count).to be(2)
        expect(subject.crumbs.last.text).to eq 'things'
        expect(subject.crumbs.last.url).to  eq '/things'
      end

      it "replaces the last crumb on the stack if the new crumb level is equal to the last" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3

        expect(subject.crumbs.count).to be(3)
        expect(subject.crumbs.last.text).to eq 'threes'
        expect(subject.crumbs.last.url).to  eq '/threes'
        expect(subject.crumbs.last.level).to eq 3

        subject.add "new_threes", "/new_threes", 3

        expect(subject.crumbs.count).to be(3)
        expect(subject.crumbs.last.text).to eq 'new_threes'
        expect(subject.crumbs.last.url).to  eq '/new_threes'
        expect(subject.crumbs.last.level).to eq 3
      end

      it "removes the last crumb on the stack if the new crumb level is less than the last" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3

        expect(subject.crumbs.count).to be(3)
        expect(subject.crumbs.last.text).to eq 'threes'
        expect(subject.crumbs.last.url).to  eq '/threes'
        expect(subject.crumbs.last.level).to eq 3

        subject.add "new_twos", "/new_twos", 2

        expect(subject.crumbs.count).to be(2)
        expect(subject.crumbs.last.text).to eq 'new_twos'
        expect(subject.crumbs.last.url).to  eq '/new_twos'
        expect(subject.crumbs.last.level).to eq 2
      end

      it "removes all crumbs on the stack until the crumb level is less than or equal to the new level" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3
        subject.add "fours", "/fours", 4

        expect(subject.crumbs.count).to be(4)
        expect(subject.crumbs.last.text).to eq 'fours'
        expect(subject.crumbs.last.url).to  eq '/fours'
        expect(subject.crumbs.last.level).to eq 4

        subject.add "new_one", "/new_one", 1

        expect(subject.crumbs.count).to be(1)
        expect(subject.crumbs.last.text).to eq 'new_one'
        expect(subject.crumbs.last.url).to  eq '/new_one'
        expect(subject.crumbs.last.level).to eq 1
      end
    end
  end
end
