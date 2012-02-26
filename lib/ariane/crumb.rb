require 'delegate'

module Ariane
  class Crumb
    attr_accessor :text, :url

    def initialize(text='', url=nil)
      @text = text
      @url  = url
    end
  end
end
