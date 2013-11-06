require 'ariane/render/html_list'

module Ariane
  module Render

    describe HTMLList do
      describe "#initialize" do
        it "sets default options" do
          expect(HTMLList.new.options.has_key?(:item_class)).to be_true
        end

        it "merges the options passed as argument to the default ones" do
          html_list = HTMLList.new(item_class: 'test')
          expect(html_list.options[:item_class]).to eq 'test'
          expect(html_list.options[:list_class]).to eq 'breadcrumb'
        end

        it "calls uses HTML default options" do
          html      = HTML.new
          html_list = HTMLList.new
          expect(html_list.options[:list_class]).to eq html.options[:list_class]
        end
      end

      describe "#list" do
        it "returns an HTML list with list_id and list_class" do
          html_list = HTMLList.new(list_id: 'test')
          expect(html_list.list([])).to eq '<ul class="breadcrumb" id="test"></ul>'
        end

        it "returns an HTML list containing crumbs" do
          html_list = HTMLList.new
          crumbs = [Crumb.new('text', 'url')]
          expect(html_list.list(crumbs)).to match(%r[<ul class="breadcrumb">.*li.*</ul>])
        end
      end

      describe "#item" do
        before :each do
          @html_list = HTMLList.new
          @crumb     = Crumb.new 'text', 'url'
        end

        it "returns the crumb in a formatted form" do
          expect(@html_list.item(@crumb)).to match(%r[^<li><a href="url">text</a>])
        end

        it "appends the divider to the crumb" do
          expect(@html_list.item(@crumb)).to match(%r[<span class="divider">/</span></li>$])
        end

        it "does not append the divider if the crumb is active" do
          expect(@html_list.item(@crumb, true)).to_not match(%r[<span class="divider">/</span></li>$])
        end

        it "uses the divider from options, not the divider method" do
          @html_list.options[:divider] = 'custom'
          expect(@html_list.item(@crumb)).to match(/custom/)
        end
      end

      describe "#link" do
        before do
          @html_list = HTMLList.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the link for the crumb" do
         expect(@html_list.link(@crumb)).to eq '<a href="url">text</a>'
        end

        it "sets the link class" do
          @html_list.options[:link_class] = 'test'
          expect(@html_list.link(@crumb)).to match(/<a /)
          expect(@html_list.link(@crumb)).to match(/class\=\"test\"/)
        end

        it "returns a link if the crumb has an url" do
          expect(@html_list.link(@crumb)).to eq '<a href="url">text</a>'
        end

        it "returns a link if the crumb is active and link_active is true" do
          @html_list.options[:link_active] = true
          expect(@html_list.link(@crumb, true)).to match(/<a /)
        end

        it "returns crumb's text if the crumb has no url" do
          @crumb.url = nil
          expect(@html_list.link(@crumb)).to eq @crumb.text
        end

        it "returns crumb's text if the crumb is active and link_active is false" do
          expect(@html_list.link(@crumb, true)).to eq @crumb.text
        end

        it "returns an html_safe string when it returns a link" do
          expect(@html_list.link(@crumb).html_safe?).to be_true
        end

        it "returns an html_safe string when it returns text" do
          @crumb.url = nil
          expect(@html_list.link(@crumb).html_safe?).to be_true
        end
      end

      describe "#divider" do
        it "returns the HTML list divider" do
          expect(HTMLList.new.divider).to eq '<span class="divider">/</span>'
        end

        it "returns the HTML list divider for a custom divider" do
          expect(HTMLList.new(divider: ' > ').divider).to eq '<span class="divider">&gt;</span>'
        end
      end
    end

  end
end
