require 'delegate'

module Ariane
  # Internal: Stores the data related to a single crumb.
  class Crumb
    # Public: Gets/Sets the String data of the crumb.
    # Public: Gets/Sets the String text of the crumb.
    # Public: Gets/Sets the String url of the crumb.
    attr_accessor :text, :url, :data 

    # Internal: Initialize a Crumb.
    #
    # text - A String representing the text of the crumb (default: '').
    # url  - A String representing the url of the crumb (default: nil).
    # data - A Hash used to store any data that can be used by renderers
    #        (default: {}).
    def initialize(text='', url=nil, data={})
      @text = text
      @url  = url
      @data = data
    end
  end
end
