require 'ariane'

module Ariane
  describe BreadcrumbStack do
    subject { BreadcrumbStack.new }

    before :each do
      subject.clear
    end

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
      it "creates a new crumb and pushes it to crumbs" do
        subject.add 'text', 'url', 1, :foo => :bar
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

      it "places a new crumb on the stack if the level is higher than the last" do
        subject.add "home", "/", 1
        subject.add "things", "/things", 2
        subject.crumbs.count.should be(2)
        subject.crumbs.last.text.should == 'things'
        subject.crumbs.last.url.should  == '/things'
      end

      it "replaces the last crumb on the stack if the new crumb level is equal to the last" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3

        subject.crumbs.count.should be(3)
        subject.crumbs.last.text.should == 'threes'
        subject.crumbs.last.url.should  == '/threes'
        subject.crumbs.last.level.should == 3

        subject.add "new_threes", "/new_threes", 3

        subject.crumbs.count.should be(3)
        subject.crumbs.last.text.should == 'new_threes'
        subject.crumbs.last.url.should  == '/new_threes'
        subject.crumbs.last.level.should == 3
      end

      it "removes the last crumb on the stack if the new crumb level is less than the last" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3

        subject.crumbs.count.should be(3)
        subject.crumbs.last.text.should == 'threes'
        subject.crumbs.last.url.should  == '/threes'
        subject.crumbs.last.level.should == 3

        subject.add "new_twos", "/new_twos", 2

        subject.crumbs.count.should be(2)
        subject.crumbs.last.text.should == 'new_twos'
        subject.crumbs.last.url.should  == '/new_twos'
        subject.crumbs.last.level.should == 2
      end

      it "removes all crumbs on the stack until the crumb level is less than or equal to the new level" do
        subject.add "home", "/", 1
        subject.add "twos", "/twos", 2
        subject.add "threes", "/threes", 3
        subject.add "fours", "/fours", 4

        subject.crumbs.count.should be(4)
        subject.crumbs.last.text.should == 'fours'
        subject.crumbs.last.url.should  == '/fours'
        subject.crumbs.last.level.should == 4

        subject.add "new_one", "/new_one", 1

        subject.crumbs.count.should be(1)
        subject.crumbs.last.text.should == 'new_one'
        subject.crumbs.last.url.should  == '/new_one'
        subject.crumbs.last.level.should == 1
      end
    end
  end
end
