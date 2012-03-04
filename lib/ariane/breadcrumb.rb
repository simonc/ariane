require 'ariane/crumb'

module Ariane
  # Internal: The Breadcrumb class is used to interact with the crumbs list.
  #
  # Examples
  #
  #   ariane.add 'Home', root_path
  #
  #   ariane.render
  class Breadcrumb
    # Internal: Returns the list of crumbs.
    #
    # Examples
    #
    #   ariane.crumbs
    #   # => [#<Crumb ...>,  ...]
    #
    # Returns an Array containing a list of Crumb objects.
    def crumbs
      @crumbs ||= []
    end

    # Public: Add a Crumb to the crumbs list.
    #
    # text - A String printed as text of crumb (default: '').
    # url  - A String used as URL of the crumb (default: nil).
    #
    # Yields the new Crumb before it is added to the list.
    #
    # Examples
    #
    #   ariane.add 'Home', root_path
    #   ariane.add 'Other'
    #
    # Returns nothing.
    def add(text='', url=nil)
      new_crumb = Crumb.new(text, url)
      yield new_crumb if block_given?
      crumbs << new_crumb
    end

    # Public: Renders the breadcrumb.
    #
    # If no renderer is provided, Ariane's default_renderer will be used.
    #
    # renderer - An instance or a class that will be used to render the
    #            breadcrumb. If a class is given the renderer will be set
    #            to a new instance of this class (default: nil).
    #
    # Examples
    #
    #   ariane.render
    #   ariane.render(SomeRendererClass)
    #
    # Returns a String representing the breadcrumb.
    def render(renderer=nil)
      renderer ||= Ariane.default_renderer
      renderer = renderer.new if renderer.is_a?(Class)
      renderer.render(crumbs)
    end
  end
end
