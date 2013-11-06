require 'ariane/render/base'

module Ariane
  module Render

    describe Base do
      subject(:base) { Base.new }

      it "has an options attribute" do
        expect(base).to respond_to(:options)
      end

      it "has a setter for the options attribute" do
        base.options = { test: 42 }
        expect(base.options).to eq(test: 42)
      end

      describe "#initialize" do
        it "sets the default options" do
          expect(base.options).to eq({ divider: ' / ' })
        end

        it "calls divider to set the default divider" do
          expect(base.options[:divider]).to eq base.divider
        end

        context "when new is called with options" do
          subject(:base) { Base.new(test: 42) }

          it "merges the passed options to the default ones" do
            expect(base.options).to eq(divider: ' / ', test: 42)
          end
        end
      end

      describe "render" do
        it "raises an exceptions when called" do
          expect { base.render }.to raise_error
        end
      end

      describe "divider" do
        it "returns the default divider" do
          expect(base.divider).to eq ' / '
        end
      end
    end

  end
end
