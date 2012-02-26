require 'ariane/render/html'

module Ariane
  module Render

    class HTMLList < HTML
      def initialize(options={})
        options = {
          item_class: nil
        }.merge(options)

        super(options)
      end

      def list(crumbs)
        content_tag(:ul, id: options[:list_id], class: options[:list_class]) do
          raw items(crumbs)
        end
      end

      def item(crumb, active=false)
        classes  = options[:item_class]
        classes << options[:active_class] if classes && active

        content_tag(:li, class: classes) do
          out = link(crumb, active)
          out << divider if divider && !active
          out
        end
      end

      def divider
        content_tag(:span, '/', class: 'divider')
      end
    end

  end
end
