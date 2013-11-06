require 'ariane/render/html_list'

module Ariane
  module Render

    describe HTMLList do
      subject(:html_list) { HTMLList.new }

      let(:crumb) { Crumb.new('text', 'url') }

      describe "#initialize" do
        it "sets default options" do
          expect(html_list.options).to have_key(:item_class)
        end

        context "when new is called with options" do
          subject(:html_list) { HTMLList.new(item_class: 'test') }

          it "merges the passed options to the default ones" do
            expect(html_list.options[:item_class]).to eq 'test'
            expect(html_list.options[:list_class]).to eq 'breadcrumb'
          end
        end

        it "uses HTML default options" do
          html = HTML.new
          expect(html_list.options[:list_class]).to eq html.options[:list_class]
        end
      end

      describe "#list" do
        let(:crumbs) { [Crumb.new('text', 'url')] }
        let(:output) { html_list.list(crumbs) }

        context "when HTMLList is given a specific list id" do
          subject(:html_list) { HTMLList.new(list_id: 'test') }

          it "returns an HTML list with the correct id" do
            expect(output).to match /<ul[^>]* id="test"/
          end
        end

        context "when HTMLList is given a specific list class" do
          subject(:html_list) { HTMLList.new(list_class: 'test') }

          it "returns an HTML list with the correct class" do
            expect(output).to match /<ul[^>]* class="test"/
          end
        end

        context "when HTMLList is not given a specific list class" do
          it "returns an HTML list with the default" do
            expect(output).to match /<ul[^>]* class="breadcrumb"/
          end
        end

        it "returns an HTML list containing crumbs" do
          expect(output).to match /<ul[^>]*>.*<li.*<\/ul>/
        end
      end

      describe "#item" do
        let(:output) { html_list.item(crumb) }

        it "returns the crumb in a formatted form" do
          expect(output).to start_with '<li><a href="url">text</a>'
        end

        it "appends the divider to the crumb" do
          expect(output).to end_with '<span class="divider">/</span></li>'
        end

        context "when the crumb is active" do
          let(:output) { html_list.item(crumb, true) }

          it "does not append the divider" do
            expect(output).not_to end_with '<span class="divider">/</span></li>'
          end
        end

        context "when a divider is given in the options" do
          before do
            html_list.options[:divider] = 'custom'
          end

          it "uses the divider from options" do
            expect(output).to match(/custom/)
          end
        end
      end

      describe "#link" do
        let(:output) { html_list.link(crumb) }

        it "returns the link for the crumb" do
         expect(output).to eq '<a href="url">text</a>'
        end

        it "sets the link class" do
          html_list.options[:link_class] = 'test'
          expect(output).to match(/<a[^>]* class="test"/)
        end

        it "returns a link if the crumb has an url" do
          expect(output).to eq '<a href="url">text</a>'
        end

        context "when the crumb is active" do
          let(:output) { html_list.link(crumb, true) }

          context "and link_active is true" do
            before do
              html_list.options[:link_active] = true
            end

            it "returns a link" do
              expect(output).to match(/<a /)
            end
          end

          context "and link_active is false" do
            it "returns a link" do
              expect(output).to eq crumb.text
            end
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

        it "returns an html_safe string when it returns a link" do
          expect(output).to be_html_safe
        end
      end

      describe "#divider" do
        it "returns the HTML list divider" do
          expect(html_list.divider).to eq '<span class="divider">/</span>'
        end

        context "when a custom divider is set" do
          subject(:html_list) { HTMLList.new(divider: ' > ') }

          it "returns the correct HTML list divider" do
            expect(html_list.divider).to eq '<span class="divider">&gt;</span>'
          end
        end
      end
    end

  end
end
