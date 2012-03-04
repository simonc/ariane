require 'ariane/render/html'

module Ariane
  module Render

    # Public: HTML renderer.
    #
    # Displays the breadcrumb as follows:
    #
    #   <ul class="breadcrumb">
    #     <li>
    #       <a href="/">Home</a>
    #       <span class="divider">/</span>
    #     </li>
    #     <li>Other</li>
    #   </ul>
    #
    class HTMLList < HTML
      # Public: Initialize an HMTLList renderer.
      #
      # options - A Hash containing options for the renderer (default: {}):
      #           :active_class - The String class used for active Crumb when
      #                           rendered as a link (default: 'active').
      #           :divider      - The String divider used to separate crumbs
      #                           (default: HTMLList#divider).
      #           :item_class   - A String class used for each breadcrumb item
      #                           (default: nil).
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
          item_class: nil
        }.merge(options)

        super(options)
      end

      # Public: Defines the breadcrumb container.
      #
      # crumbs - An Array containing a list of Crumb objects composing the
      #          breadcrumb.
      #
      # Examples
      #
      #   htmllist.list(crumbs)
      #   # => "<ul class=\"breadcrumb\"> ... </ul>"
      #   # The String returned cannot be considered as html safe.
      #
      # Returns a non html safe String representing the breadcrumb.
      def list(crumbs)
        content_tag(:ul, id: options[:list_id], class: options[:list_class]) do
          raw items(crumbs)
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
      #   htmllist.item(crumb)
      #   # => "<li><a href=\"/\">Home</a><span class=\"divider\">/</span></li>"
      #
      #   # If the :item_class options is set to 'crumb':
      #   htmllist.item(crumb)
      #   # => "<li class=\"crumb\"> ... </li>"
      #
      #   htmllist.item(crumb, true)
      #   # => "<li>Home</li>"
      #
      #   htmllist.item(crumb, true)
      #   # => "<li class=\"active\">Home</li>"
      #
      # Returns an hmtl safe String representing a rendered Crumb item.
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

      # Public: Returns a Crumb link.
      #
      # crumb  - The Crumb item to be rendered.
      # active - A Boolean indicating if the Crumb is active or not
      #          (default: false).
      #
      # Examples
      #
      #   htmllist.link(crumb)
      #   # => "<a href=\"/\">Home</a>"
      #
      #   # If the :link_active option is false:
      #   htmllist.link(crumb, true)
      #   # => "Home"
      #
      # Returns an html safe String representing the link for the Crumb item.
      def link(crumb, active=false)
        link_active = !active || options[:link_active]
        if crumb.url && link_active
          link = link_to crumb.text, crumb.url, class: options[:link_class]
        else
          link = crumb.text
        end
        link.html_safe
      end

      # Public: Returns the divider used to separate crumbs.
      #
      # Examples
      #
      #   htmllist.divider
      #   # => "<span class=\"divider\">/</span>"
      #
      # Returns the String representing the html divider.
      def divider
        content_tag(:span, '/', class: 'divider')
      end
    end

  end
end
