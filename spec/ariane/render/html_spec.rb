require 'ariane/render/html'

module Ariane
  module Render

    describe HTML do
      subject(:html) { HTML.new }

      let(:crumb) { Crumb.new('text', 'url') }
      let(:crumbs) { [Crumb.new('text1', 'url1'), Crumb.new('text2', 'url2')] }

      it "has an output_buffer" do
        expect(html).to respond_to(:output_buffer)
      end

      it "has a setter for the output_buffer" do
        expect(html).to respond_to(:'output_buffer=')
      end

      describe "#initialize" do
        it "sets default options" do
          expect(html.options[:list_class]).to eq 'breadcrumb'
        end

        context "when new is called with options" do
          subject(:html) { HTML.new(list_id: 'test') }

          it "merges the passed options to the default ones" do
            expect(html.options[:list_id]).to eq 'test'
            expect(html.options[:list_class]).to eq 'breadcrumb'
          end
        end

        it "calls uses Base default options" do
          expect(html.options[:divider]).to eq ' / '
        end
      end

      describe "#render" do
        let(:output) { html.render([]) }

        it "returns an html_safe string" do
          html.stub(:list).and_return('test')
          expect(output).to be_html_safe
        end
      end

      describe "#list" do
        let(:output) { html.list(crumbs) }

        context "when HTML is given a list id" do
          subject(:html) { HTML.new(list_id: 'test') }

          it "returns an HTML paragraph with correct list id" do
            expect(output).to match /<p[^>]* id="test"[^>]*>/
          end
        end

        it "returns an HTML paragraph containing crumbs" do
          expect(output).to match %r[<p[^>]*><a href="url1">text1</a> / text2</p>]
        end
      end

      describe "#items" do
        let(:output) { html.items(crumbs) }

        it "returns all crumbs in a formatted form" do
          expect(output).to eq '<a href="url1">text1</a> / text2'
        end

        it "sets the active flag for the last item" do
          expect(html).to receive(:item).with(crumbs.first, false).and_return('')
          expect(html).to receive(:item).with(crumbs.last, true).and_return('')
          html.items(crumbs)
        end
      end

      describe "#item" do
        let(:output) { html.item(crumb) }

        it "returns the crumb in a formatted form" do
          expect(output).to start_with '<a href="url">text</a>'
        end

        it "appends the divider to the crumb" do
          expect(output).to end_with ' / '
        end

        context "when the crumb is active" do
          let(:output) { html.item(crumb, true) }

          it "does not append the divider" do
            expect(output).to_not end_with ' / '
          end
        end

        context "when a custom divider is set" do
          before do
            html.options[:divider] = 'custom'
          end

          it "uses the divider from options" do
            expect(output).to match /custom/
          end
        end
      end

      describe "#link" do
        let(:output) { html.link(crumb) }

        it "returns the link for the crumb" do
          expect(output).to eq '<a href="url">text</a>'
        end

        it "sets the link class" do
          html.options[:link_class] = 'test'
          expect(output).to match /<a[^>]* class="test"/
        end

        context "when the crumb is active" do
          let(:output) { html.link(crumb, true) }

          context "and link_active is true" do
            before do
              html.options[:link_active] = true
            end

            it "returns a link with the active class" do
              expect(output).to match(/<a[^>]* class="active"/)
            end
          end

          context "and link_active is true" do
            it "returns crumb's text" do
              expect(output).to eq crumb.text
            end
          end
        end

        context "when the crumb has an url" do
          it "returns a link" do
            expect(output).to eq '<a href="url">text</a>'
          end

          it "returns an html_safe string" do
            expect(output).to be_html_safe
          end
        end

        context "when the crumb has no url" do
          before do
            crumb.url = nil
          end

          it "returns crumb's text" do
            expect(output).to eq crumb.text
          end

          it "returns an html_safe string" do
            expect(output).to be_html_safe
          end
        end
      end
    end

  end
end
