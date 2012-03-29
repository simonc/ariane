module Ariane
  module Render

    # Internal: Base renderer from which every renderer inherits.
    class Base
      # Internal: Gets/Sets the Hash options.
      attr_accessor :options

      # Public: Initialize a Base renderer.
      #
      # options - A Hash containing options for the renderer (default: {}):
      #           :divider - The String divider used to separate crumbs
      #                      (default: Base#divider).
      def initialize(options={})
        @options = {
          divider: ' / '
        }.merge(options)
      end

      # Internal: Renders the breadcrumbs.
      #
      # This method MUST be overridden by any renderer inheriting from Base.
      #
      # crumbs - An Array containing a list of Crumb objects composing the
      #          breadcrumb.
      #
      # Returns nothing.
      # Raises RuntimeError everytime.
      def render(crumbs)
        raise 'the render method is not implemented in your Ariane renderer'
      end

      # Public: Returns the divider used to separate crumbs.
      #
      # Returns the String ' / '.
      def divider
        ' / '
      end
    end

  end
end
