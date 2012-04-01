module Ariane
  # Adds the ariane helper to controllers.
  module ControllerHelper
    def ariane
      # Set environment and a reference to the session 
      if !Ariane.request_env || Ariane.request != request.object_id
        Ariane.request     = request.object_id
        Ariane.request_env = request.env
        Ariane.session     = session if Ariane.use_session_stack
      end

      Ariane.breadcrumb
    end
  end
end

ActionController::Base.send :include, Ariane::ControllerHelper
