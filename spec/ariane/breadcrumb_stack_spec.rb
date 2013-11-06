require 'ariane'

module Ariane
  describe BreadcrumbStack do
    subject(:stack) { BreadcrumbStack.new }

    before { stack.clear }

    describe "#crumbs" do
      it "has a crumbs method that returns an Enumerable" do
        expect(stack.crumbs).to be_an(Enumerable)
      end

      it "set the crumbs to an empty Enumerable by default" do
        expect(stack.crumbs).to respond_to :count
        expect(stack.crumbs.count).to eq 0
      end
    end

    describe "#add" do
      it "creates a new crumb and pushes it to crumbs" do
        stack.add 'text', 'url', 1, foo: :bar

        expect(stack.crumbs.count).to eq 1
        expect(stack.crumbs.last.text).to eq 'text'
        expect(stack.crumbs.last.url).to  eq 'url'
        expect(stack.crumbs.last.data).to eq(foo: :bar)
      end

      it "yields passing the new crumb if a block is given" do
        stack.add 'text' do |crumb|
          crumb.url = 'url'
        end

        expect(stack.crumbs.last.url).to eq 'url'
      end

      it "places a new crumb on the stack if the level is higher than the last" do
        stack.add 'home', '/', 1
        stack.add 'things', '/things', 2

        expect(stack.crumbs.count).to eq 2
        expect(stack.crumbs.last.text).to eq 'things'
        expect(stack.crumbs.last.url).to  eq '/things'
      end

      it "replaces the last crumb on the stack if the new crumb level is equal to the last" do
        stack.add 'home', '/', 1
        stack.add 'twos', '/twos', 2
        stack.add 'threes', '/threes', 3

        expect(stack.crumbs.count).to eq 3
        expect(stack.crumbs.last.text).to eq 'threes'
        expect(stack.crumbs.last.url).to  eq '/threes'
        expect(stack.crumbs.last.level).to eq 3

        stack.add 'new_threes', '/new_threes', 3

        expect(stack.crumbs.count).to eq 3
        expect(stack.crumbs.last.text).to eq 'new_threes'
        expect(stack.crumbs.last.url).to  eq '/new_threes'
        expect(stack.crumbs.last.level).to eq 3
      end

      it "removes the last crumb on the stack if the new crumb level is less than the last" do
        stack.add 'home', '/', 1
        stack.add 'twos', '/twos', 2
        stack.add 'threes', '/threes', 3

        expect(stack.crumbs.count).to eq 3
        expect(stack.crumbs.last.text).to eq 'threes'
        expect(stack.crumbs.last.url).to  eq '/threes'
        expect(stack.crumbs.last.level).to eq 3

        stack.add 'new_twos', '/new_twos', 2

        expect(stack.crumbs.count).to eq 2
        expect(stack.crumbs.last.text).to eq 'new_twos'
        expect(stack.crumbs.last.url).to  eq '/new_twos'
        expect(stack.crumbs.last.level).to eq 2
      end

      it "removes all crumbs on the stack until the crumb level is less than or equal to the new level" do
        stack.add 'home', '/', 1
        stack.add 'twos', '/twos', 2
        stack.add 'threes', '/threes', 3
        stack.add 'fours', '/fours', 4

        expect(stack.crumbs.count).to eq 4
        expect(stack.crumbs.last.text).to eq 'fours'
        expect(stack.crumbs.last.url).to  eq '/fours'
        expect(stack.crumbs.last.level).to eq 4

        stack.add 'new_one', '/new_one', 1

        expect(stack.crumbs.count).to eq 1
        expect(stack.crumbs.last.text).to eq 'new_one'
        expect(stack.crumbs.last.url).to  eq '/new_one'
        expect(stack.crumbs.last.level).to eq 1
      end
    end
  end
end
