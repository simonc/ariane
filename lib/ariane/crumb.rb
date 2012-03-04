require 'delegate'

module Ariane
  # Internal: Stores the data related to a single crumb.
  class Crumb
    # Public: Gets/Sets the String text of the crumb.
    # Public: Gets/Sets the String url of the crumb.
    attr_accessor :text, :url

    # Internal: Initialize a Crumb.
    #
    # text - A String representing the text of the crumb (default: '').
    # url  - A String representing the url of the crumb (default: nil).
    def initialize(text='', url=nil)
      @text = text
      @url  = url
    end
  end
end
