require 'ariane/crumb'

module Ariane
  class Breadcrumb
    def crumbs
      @crumbs ||= []
    end

    def add(text='', url=nil)
      new_crumb = Crumb.new(text, url)
      yield new_crumb if block_given?
      crumbs << new_crumb
    end

    def render(renderer=nil)
      renderer ||= Ariane.default_renderer
      renderer = renderer.new if renderer.is_a?(Class)
      renderer.render(crumbs)
    end
  end
end
