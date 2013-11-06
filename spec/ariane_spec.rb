require 'simplecov'
SimpleCov.start

require 'ariane'

describe Ariane do
  before do
    Ariane.request_env      = {}
    Ariane.default_renderer = nil
  end

  describe "#configure" do
    it "passes Ariane to the given block" do
      Ariane.configure do |config|
        config.default_renderer = 'test_renderer'
      end
      expect(Ariane.default_renderer).to eq 'test_renderer'
    end
  end

   describe "#request_env=" do
     it "sets the breadcrumb request env variable" do
       Ariane.request_env = {}
       expect(Ariane.request_env[:breadcrumb]).to_not eq({})
     end
   end

  describe "#breadcrumb" do
    it "returns the breadcrumb from the request_env" do
      Ariane.request_env[:breadcrumb] = 'test_breadcrumb'
      expect(Ariane.breadcrumb).to eq 'test_breadcrumb'
    end
  end

  describe "#breadcrumb=" do
    it "sets the breadcrumb in the request_env" do
      Ariane.breadcrumb = 'test_breadcrumb'
      expect(Ariane.request_env[:breadcrumb]).to eq 'test_breadcrumb'
    end
  end

  describe "#default_renderer" do
    it "returns the default renderer" do
      Ariane.default_renderer = 'test_renderer'
      expect(Ariane.default_renderer).to eq 'test_renderer'
    end
  end

  describe "#default_renderer=" do
    it "instanciates the renderer if a class is passed" do
      Ariane.default_renderer = String
     expect(Ariane.default_renderer).to eq ''
    end
  end

  describe "#dynamic_breadcrumb" do
    it "returns the default mode which is false" do
      expect(Ariane.dynamic_breadcrumb).to be_false
    end
  end

  describe "#dynamic_breadcrumb=" do
    it "returns the option set" do
      Ariane.dynamic_breadcrumb = true
      expect(Ariane.dynamic_breadcrumb).to be_true
    end
  end
end
