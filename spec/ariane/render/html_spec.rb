require 'ariane/render/html'

module Ariane
  module Render

    describe HTML do
      it "has an output_buffer" do
        HTML.new.respond_to?(:output_buffer)
      end

      it "has a setter for the output_buffer" do
        HTML.new.respond_to?(:"output_buffer=")
      end

      describe "#initialize" do
        it "sets default options" do
          HTML.new.options[:list_class].should == 'breadcrumb'
        end

        it "merges the options passed as argument to the default ones" do
          html = HTML.new(list_id: 'test')
          html.options[:list_id].should    == 'test'
          html.options[:list_class].should == 'breadcrumb'
        end

        it "calls uses Base default options" do
          HTML.new.options[:divider].should == ' / '
        end
      end

      describe "#render" do
        it "returns an html_safe string" do
          html = HTML.new
          html.stub(:list).and_return('test')
          html.render([]).html_safe?.should be_true
        end
      end

      describe "#list" do
        it "returns an HTML paragraph with list_id and list_class" do
          html = HTML.new(list_id: 'test')
          html.list([]).should == '<p class="breadcrumb" id="test"></p>'
        end

        it "returns an HTML paragraph containing crumbs" do
          html   = HTML.new
          crumbs = [Crumb.new('text1', 'url1'), Crumb.new('text2', 'url2')]
          html.list(crumbs).should == '<p class="breadcrumb"><a href="url1">text1</a> / text2</p>'
        end
      end

      describe "#items" do
        it "returns all crumbs in a formatted form" do
          html   = HTML.new
          crumbs = [Crumb.new('text1', 'url1'), Crumb.new('text2', 'url2')]
          html.items(crumbs).should == '<a href="url1">text1</a> / text2'
        end

        it "sets the active flag for the last item" do
          html   = HTML.new
          crumbs = [Crumb.new('text', 'url'), Crumb.new('text', 'url')]
          html.should_receive(:item).with(crumbs.first, false).and_return('')
          html.should_receive(:item).with(crumbs.last, true).and_return('')
          html.items(crumbs)
        end
      end

      describe "#item" do
        before :each do
          @html  = HTML.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the crumb in a formatted form" do
          @html.item(@crumb).should =~ %r[^<a href="url">text</a>]
        end

        it "appends the divider to the crumb" do
          @html.item(@crumb).should =~ %r[ / $]
        end

        it "does not append the divider if the crumb is active" do
          @html.item(@crumb, true).should_not =~ %r[ / $]
        end

        it "uses the divider from options, not the divider method" do
          @html.options[:divider] = 'custom'
          @html.item(@crumb).should =~ /custom/
        end
      end

      describe "#link" do
        before do
          @html  = HTML.new
          @crumb = Crumb.new 'text', 'url'
        end

        it "returns the link for the crumb" do
          @html.link(@crumb).should == '<a href="url">text</a>'
        end

        it "sets the link class" do
          @html.options[:link_class] = 'test'
          @html.link(@crumb).should =~ /<a /
          @html.link(@crumb).should =~ /class\=\"test\"/
          @html.link(@crumb).should =~ /href\=\"url\"/
          @html.link(@crumb).should =~ /text\<\/a\>/
        end

        it "sets the active class when the crumb is active and link_active is true" do
          @html.options[:link_active] = true
          @html.link(@crumb, true).should =~ /<a /
          @html.link(@crumb, true).should =~ /class\=\"active\"/
          @html.link(@crumb, true).should =~ /href\=\"url\"/
          @html.link(@crumb, true).should =~ /text\<\/a\>/
        end

        it "returns a link if the crumb has an url" do
          @html.link(@crumb).should == '<a href="url">text</a>'
        end

        it "returns a link if the crumb is active and link_active is true" do
          @html.options[:link_active] = true
          @html.link(@crumb, true).should =~ /<a /
        end

        it "returns crumb's text if the crumb has no url" do
          @crumb.url = nil
          @html.link(@crumb).should == @crumb.text
        end

        it "returns crumb's text if the crumb is active and link_active is false" do
          @html.link(@crumb, true).should == @crumb.text
        end

        it "returns an html_safe string when it returns a link" do
          @html.link(@crumb).html_safe?.should be_true
        end

        it "returns an html_safe string when it returns text" do
          @crumb.url = nil
          @html.link(@crumb).html_safe?.should be_true
        end
      end
    end

  end
end
