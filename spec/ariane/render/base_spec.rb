require 'ariane/render/base'

module Ariane
  module Render

    describe Base do
      it "has an options attribute" do
        expect(Base.new.respond_to?(:options)).to be_true
      end

      it "has a setter for the options attribute" do
        base = Base.new
        base.options = { test: 42 }
        expect((base.options)).to eq({ test: 42 })
      end

      describe "#initialize" do
        it "sets the default options" do
          expect(Base.new.options).to eq({ divider: ' / ' })
        end

        it "calls divider to set the default divider" do
          base = Base.new
          expect(base.options[:divider]).to eq base.divider
        end

        it "merges the options passed as argument to the default ones" do
          expect(Base.new(test: 42).options).to eq({ divider: ' / ', test: 42 })
        end
      end

      describe "render" do
        it "raises an exceptions when called" do
          expect { Base.new.render }.to raise_error
        end
      end

      describe "divider" do
        it "returns the default divider" do
          expect(Base.new.divider).to eq ' / '
        end
      end
    end

  end
end
