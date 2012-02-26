module Ariane
  module Render

    class Base
      attr_accessor :options

      def initialize(options={})
        @options = {
          divider: divider
        }.merge(options)
      end

      def render(crumbs)
        raise 'the render method is not implemented in your Ariane renderer'
      end

      def divider
        ' / '
      end
    end

  end
end