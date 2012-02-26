require 'ariane/render/base'

module Ariane
  module Render

    describe Base do
      it "has an options attribute" do
        Base.new.respond_to?(:options).should be_true
      end

      it "has a setter for the options attribute" do
        base = Base.new
        base.options = { test: 42 }
        base.options.should == { test: 42 }
      end

      describe "#initialize" do
        it "sets the default options" do
          Base.new.options.should == { divider: ' / ' }
        end

        it "calls divider to set the default divider" do
          base = Base.new
          base.options[:divider].should == base.divider
        end

        it "merges the options passed as argument to the default ones" do
          Base.new(test: 42).options.should == { divider: ' / ', test: 42 }
        end
      end

      describe "render" do
        it "raises an exceptions when called" do
          expect { Base.new.render }.to raise_error
        end
      end

      describe "divider" do
        it "returns the default divider" do
          Base.new.divider.should == ' / '
        end
      end
    end

  end
end