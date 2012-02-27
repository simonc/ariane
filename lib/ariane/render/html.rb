require 'ariane/render/base'
require 'action_view'

module Ariane
  module Render

    class HTML < Base
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::OutputSafetyHelper

      attr_accessor :output_buffer

      def initialize(options={})
        options = {
          active_class: 'active',
          link_active:  false,
          link_class:   nil,
          list_class:   'breadcrumb',
          list_id:      nil
        }.merge(options)

        super(options)
      end

      def render(crumbs)
        list(crumbs).html_safe
      end

      def list(crumbs)
        content_tag(:p, id: options[:list_id], class: options[:list_class]) do
          raw items(crumbs)
        end
      end

      def items(crumbs)
        crumbs.inject('') do |out, crumb|
          active = crumb == crumbs.last
          out << item(crumb, active)
          out
        end
      end

      def item(crumb, active=false)
        out = link(crumb, active)
        out << options[:divider] if options[:divider] && !active
        out
      end

      def link(crumb, active=false)
        classes = options[:link_class]

        if active && options[:active_class]
          classes ||= ''
          classes << options[:active_class]
        end

        link_active = !active || options[:link_active]
        if crumb.url && link_active
          link = link_to crumb.text, crumb.url, class: classes
        else
          link = crumb.text
        end
        link.html_safe
      end
    end

  end
end