require 'ariane/crumb'

module Ariane
  # Internal: The BreadcrumbStack class is used to interact with the crumbs list.
  #
  # Examples
  #
  #   ariane.add 'Home', root_path, 1
  #
  #   ariane.render
  class BreadcrumbStack < Ariane::Breadcrumb

    # Public: Add a Crumb to the crumbs list.
    #
    # args - Any arguments that can be passed to Crumb#initialize.
    #
    # Yields the new Crumb before it is added to the list.
    #
    # Examples
    #
    #   ariane.add 'Home', root_path, 1
    #   ariane.add 'Other', other_path, 2
    #   ariane.add 'Foo', root_path, 2, :foo => :bar
    #
    # Returns nothing.
    def add(*args)
      new_crumb = LevelCrumb.new(*args)
      yield new_crumb if block_given?

      crumbs.pop while crumbs.any? && crumbs.last.level >= new_crumb.level

      crumbs << new_crumb
    end

    def clear
      crumbs.clear
    end
  end
end
