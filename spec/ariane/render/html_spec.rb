require 'ariane/render/html'

module Ariane
  module Render

    describe HTML do
      it "has an output_buffer" do
        expect(HTML.new.respond_to?(:output_buffer)).to be_true
      end

      it "has a setter for the output_buffer" do
        expect(HTML.new.respond_to?(:"output_buffer=")).to be_true
      end

      describe "#initialize" do
        it "sets default options" do
          expect(HTML.new.options[:list_class]).to eq 'breadcrumb'
        end

        it "merges the options passed as argument to the default ones" do
          html = HTML.new(list_id: 'test')
          expect(html.options[:list_id]).to eq 'test'
          expect(html.options[:list_class]).to eq 'breadcrumb'
        end

        it "calls uses Base default options" do
          expect(HTML.new.options[:divider]).to eq ' / '
        end
      end

      describe "#render" do
        it "returns an html_safe string" do
          html = HTML.new
          html.stub(:list).and_return('test')
          expect(html.render([]).html_safe?).to be_true
        end
      end

      describe "#list" do
        it "returns an HTML paragraph with list_id and list_class" do
          html = HTML.new(list_id: 'test')
          expect(html.list([])).to eq '<p class="breadcrumb" id="test"></p>'
        end

        it "returns an HTML paragraph containing crumbs" do
          html   = HTML.new
          crumbs = [Crumb.new('text1', 'url1'), Crumb.new('text2', 'url2')]
          expect(html.list(crumbs)).to eq '<p class="breadcrumb"><a href="url1">text1</a> / text2</p>'
        end
      end

      describe "#items" do
        it "returns all crumbs in a formatted form" do
          html   = HTML.new
          crumbs = [Crumb.new('text1', 'url1'), Crumb.new('text2', 'url2')]
          expect(html.items(crumbs)).to eq '<a href="url1">text1</a> / text2'
        end

        it "sets the active flag for the last item" do
          html   = HTML.new
          crumbs = [Crumb.new('text', 'url'), Crumb.new('text', 'url')]
          expect(html).to receive(:item).with(crumbs.first, false).and_return('')
          expect(html).to receive(:item).with(crumbs.last, true).and_return('')
          html.items(crumbs)
        end
      end

      describe "#item" do
        before :each do
          @html  = HTML.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the crumb in a formatted form" do
          expect(@html.item(@crumb)).to match(%r[^<a href="url">text</a>])
        end

        it "appends the divider to the crumb" do
          expect(@html.item(@crumb)).to match(%r[ / $])
        end

        it "does not append the divider if the crumb is active" do
          expect(@html.item(@crumb, true)).to_not match(%r[ / $])
        end

        it "uses the divider from options, not the divider method" do
          @html.options[:divider] = 'custom'
          expect(@html.item(@crumb)).to match(/custom/)
        end
      end

      describe "#link" do
        before do
          @html  = HTML.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the link for the crumb" do
          expect(@html.link(@crumb)).to eq '<a href="url">text</a>'
        end

        it "sets the link class" do
          @html.options[:link_class] = 'test'
          expect(@html.link(@crumb)).to match(/<a /)
          expect(@html.link(@crumb)).to match(/class\=\"test\"/)
          expect(@html.link(@crumb)).to match(/href\=\"url\"/)
          expect(@html.link(@crumb)).to match(/text\<\/a\>/)
        end

        it "sets the active class when the crumb is active and link_active is true" do
          @html.options[:link_active] = true
          expect(@html.link(@crumb, true)).to match(/<a /)
          expect(@html.link(@crumb, true)).to match(/class\=\"active\"/)
          expect(@html.link(@crumb, true)).to match(/href\=\"url\"/)
          expect(@html.link(@crumb, true)).to match(/text\<\/a\>/)
        end

        it "returns a link if the crumb has an url" do
          expect(@html.link(@crumb)).to eq '<a href="url">text</a>'
        end

        it "returns a link if the crumb is active and link_active is true" do
          @html.options[:link_active] = true
          expect(@html.link(@crumb, true)).to match(/<a /)
        end

        it "returns crumb's text if the crumb has no url" do
          @crumb.url = nil
          expect(@html.link(@crumb)).to eq @crumb.text
        end

        it "returns crumb's text if the crumb is active and link_active is false" do
          expect(@html.link(@crumb, true)).to eq @crumb.text
        end

        it "returns an html_safe string when it returns a link" do
          expect(@html.link(@crumb).html_safe?).to be_true
        end

        it "returns an html_safe string when it returns text" do
          @crumb.url = nil
          expect(@html.link(@crumb).html_safe?).to be_true
        end
      end
    end

  end
end
