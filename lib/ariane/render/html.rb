require 'ariane/render/base'
require 'action_view'

module Ariane
  module Render

    # Public: HTML renderer.
    #
    # Displays the breadcrumb as follows:
    #
    #   <p class="breadcrumb">
    #     <a href="/">Home</a> / Other
    #   </p>
    #
    class HTML < Base
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::OutputSafetyHelper

      # Public: Gets/Sets the String output_buffer.
      attr_accessor :output_buffer

      # Public: Initialize an HTML renderer.
      #
      # options - A Hash containing options for the renderer (default: {}):
      #           :active_class - The String class used for active Crumb when
      #                           rendered as a link (default: 'active').
      #           :divider      - The String divider used to separate crumbs
      #                           (default: Base#divider).
      #           :link_active  - A Boolean telling if the active Crumb should
      #                           be rendered as a link (default: false).
      #           :link_class   - The String html class for each link
      #                           (default: nil).
      #           :list_class   - The String html class used for the crumbs list
      #                           container (default: 'breadcrumb').
      #           :list_id      - The String html id used for the crumbs list
      #                           container (default: nil).
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

      # Public: Renders the breadcrumb.
      #
      # crumbs - An Array containing a list of Crumb objects composing the
      #          breadcrumb.
      #
      # Examples
      #
      #   html.render(crumbs)
      #   # => "<p class=\"breadcrumb\"><a href=\"/\">Home</a> / Other</p>"
      #
      # Returns an html safe String representing the breadcrumb to print.
      def render(crumbs)
        list(crumbs).html_safe
      end

      # Public: Defines the breadcrumb container.
      #
      # crumbs - An Array containing a list of Crumb objects composing the
      #          breadcrumb.
      #
      # Examples
      #
      #   html.list(crumbs)
      #   # => "<p class=\"breadcrumb\"> ... </p>"
      #   # The String returned cannot be considered as html safe.
      #
      # Returns a non html safe String representing the breadcrumb.
      def list(crumbs)
        content_tag(:p, id: options[:list_id], class: options[:list_class]) do
          raw items(crumbs)
        end
      end

      # Public: Returns the rendered list of breadcrumb items.
      #
      # crumbs - An Array containing a list of Crumb objects composing the
      #          breadcrumb.
      #
      # Examples
      #
      #   html.items(crumbs)
      #   # => "<a href=\"/\">Home</a> / Other"
      #   # The String returned cannot be considered as html safe.
      #
      # Returns a non html safe String representing the breadcrumb items.
      def items(crumbs)
        crumbs.inject('') do |out, crumb|
          active = crumb == crumbs.last
          out << item(crumb, active)
          out
        end
      end

      # Public: Returns a rendered breadcrumb item.
      #
      # Appends the divider unless active is true.
      #
      # crumb  - The Crumb item to be rendered.
      # active - A Boolean indicating if the Crumb is active or not
      #          (default: false).
      #
      # Examples
      #
      #   html.item(crumb)
      #   # => "<a href=\"/\">Home</a> /"
      #
      #   html.item(crumb, true)
      #   # => "Home"
      #
      # Returns an hmtl safe String representing a rendered Crumb item.
      def item(crumb, active=false)
        out = link(crumb, active)
        out << options[:divider] if options[:divider] && !active
        out
      end

      # Public: Returns a Crumb link.
      #
      # crumb  - The Crumb item to be rendered.
      # active - A Boolean indicating if the Crumb is active or not
      #          (default: false).
      #
      # Examples
      #
      #   html.link(crumb)
      #   # => "<a href=\"/\">Home</a>"
      #
      #   # If the :link_active option is false:
      #   html.link(crumb, true)
      #   # => "Home"
      #
      #   # If the :link_active option is true and
      #   # the :link_class option is set to 'active':
      #   html.link(crumb, true)
      #   # => "<a href=\"/\" class=\"active\">Home</a>"
      #
      # Returns an html safe String representing the link for the Crumb item.
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