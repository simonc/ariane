
module Ariane
  # Internal: Stores the data related to a single level-based crumb.
  class LevelCrumb < Ariane::Crumb
    # Public: Gets/Sets the Integer level of the crumb.
    attr_accessor :level

    # Internal: Initialize a Crumb.
    #
    # text  - A String representing the text of the crumb (default: '').
    # url   - A String representing the url of the crumb (default: nil).
    # level - An Integer value representing the level of the crumb (default: 1).
    # data  - A Hash used to store any data that can be used by renderers
    #        (default: {}).
    def initialize(text='', url=nil, level=1, data={})
      super text, url, data
      @level = level
    end
  end
end
