require 'ariane/render/html_list'

module Ariane
  module Render

    describe HTMLList do
      describe "#initialize" do
        it "sets default options" do
          HTMLList.new.options.has_key?(:item_class).should be_true
        end

        it "merges the options passed as argument to the default ones" do
          html_list = HTMLList.new(item_class: 'test')
          html_list.options[:item_class].should == 'test'
          html_list.options[:list_class].should == 'breadcrumb'
        end

        it "calls uses HTML default options" do
          html      = HTML.new
          html_list = HTMLList.new
          html_list.options[:list_class].should == html.options[:list_class]
        end
      end

      describe "#list" do
        it "returns an HTML list with list_id and list_class" do
          html_list = HTMLList.new(list_id: 'test')
          html_list.list([]).should == '<ul class="breadcrumb" id="test"></ul>'
        end

        it "returns an HTML list containing crumbs" do
          html_list = HTMLList.new
          crumbs = [Crumb.new('text', 'url')]
          html_list.list(crumbs).should =~ %r[<ul class="breadcrumb">.*li.*</ul>]
        end
      end

      describe "#item" do
        before :each do
          @html_list = HTMLList.new
          @crumb     = Crumb.new 'text', 'url'
        end

        it "returns the crumb in a formatted form" do
          @html_list.item(@crumb).should =~ %r[^<li><a href="url">text</a>]
        end

        it "appends the divider to the crumb" do
          @html_list.item(@crumb).should =~ %r[<span class="divider">/</span></li>$]
        end

        it "does not append the divider if the crumb is active" do
          @html_list.item(@crumb, true).should_not =~ %r[<span class="divider">/</span></li>$]
        end

        it "uses the divider from options, not the divider method" do
          @html_list.options[:divider] = 'custom'
          @html_list.item(@crumb).should =~ /custom/
        end
      end

      describe "#link" do
        before do
          @html_list = HTMLList.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the link for the crumb" do
          @html_list.link(@crumb).should == '<a href="url">text</a>'
        end

        it "sets the link class" do
          @html_list.options[:link_class] = 'test'
          @html_list.link(@crumb).should == '<a href="url" class="test">text</a>'
        end

        it "returns a link if the crumb has an url" do
          @html_list.link(@crumb).should == '<a href="url">text</a>'
        end

        it "returns a link if the crumb is active and link_active is true" do
          @html_list.options[:link_active] = true
          @html_list.link(@crumb, true).should =~ /<a /
        end

        it "returns crumb's text if the crumb has no url" do
          @crumb.url = nil
          @html_list.link(@crumb).should == @crumb.text
        end

        it "returns crumb's text if the crumb is active and link_active is false" do
          @html_list.link(@crumb, true).should == @crumb.text
        end
      end

      describe "#divider" do
        it "returns the HTML list divider" do
          HTMLList.new.divider.should == '<span class="divider">/</span>'
        end
      end
    end

  end
end
