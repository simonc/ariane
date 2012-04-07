require 'simplecov'
SimpleCov.start

require 'ariane'

describe Ariane do
  before :each do
    Ariane.request_env      = {}
    Ariane.default_renderer = nil
  end

  describe "#configure" do
    it "passes Ariane to the given block" do
      Ariane.configure do |config|
        config.default_renderer = 'test_renderer'
      end
      Ariane.default_renderer.should == 'test_renderer'
    end
  end

  describe "#request_env=" do
    it "sets the breacrumb env variable" do
      Ariane.request_env = {}
      Ariane.request_env[:breadcrumb].should_not be_nil
    end
  end

  describe "#breadcrumb" do
    it "returns the breadcrumb from the request_env" do
      Ariane.request_env[:breadcrumb] = "test_breadcrumb"
      Ariane.breadcrumb.should == "test_breadcrumb"
    end
  end

  describe "#breadcrumb=" do
    it "sets the breadcrumb in the request_env" do
      Ariane.breadcrumb = "test_breadcrumb"
      Ariane.request_env[:breadcrumb].should == "test_breadcrumb"
    end
  end

  describe "#default_renderer" do
    it "returns the default renderer" do
      Ariane.default_renderer = "test_renderer"
      Ariane.default_renderer.should == "test_renderer"
    end
  end

  describe "#default_renderer=" do
    it "instanciates the renderer if a class is passed" do
      Ariane.default_renderer = String
      Ariane.default_renderer.should == ""
    end
  end
end
