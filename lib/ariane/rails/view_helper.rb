module Ariane
  module ViewHelper
    def ariane
      Ariane.breadcrumb
    end
  end
end

ActionView::Base.send :include, Ariane::ViewHelper
