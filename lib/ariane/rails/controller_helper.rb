module Ariane
  # Adds the ariane helper to controllers.
  module ControllerHelper
    def ariane
      if !Ariane.request_env || Ariane.request != request.object_id
        Ariane.request     = request.object_id
        Ariane.request_env = request.env
        Ariane.breadcrumb  = Breadcrumb.new
      end

      Ariane.request_env[:breadcrumb]
    end
  end
end

ActionController::Base.send :include, Ariane::ControllerHelper
