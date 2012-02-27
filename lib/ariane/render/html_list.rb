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
        classes = options[:item_class]

        if active && options[:active_class]
          classes ||= ''
          classes << options[:active_class]
        end

        content_tag(:li, class: classes) do
          out = link(crumb, active)
          out << options[:divider] if options[:divider] && !active
          out
        end
      end

      def link(crumb, active=false)
        link_active = !active || options[:link_active]
        if crumb.url && link_active
          link = link_to crumb.text, crumb.url, class: options[:link_class]
        else
          link = crumb.text
        end
        link
      end

      def divider
        content_tag(:span, '/', class: 'divider')
      end
    end

  end
end
