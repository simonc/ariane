module Ariane
  # Adds the ariane helper to views.
  module ViewHelper
    def ariane
      Ariane.breadcrumb
    end
  end
end

ActionView::Base.send :include, Ariane::ViewHelper
