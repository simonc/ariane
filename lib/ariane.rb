require 'ariane/version'
require 'ariane/crumb'
require 'ariane/breadcrumb'
require 'ariane/breadcrumb_stack'
require 'ariane/render'

require 'ariane/rails' if defined?(Rails)

module Ariane
  class << self
    attr_accessor :request, :use_session_stack

    # Public: Provides a simple way to access Ariane configuration.
    #
    # Yields self.
    #
    # Examples
    #
    #   Ariane.configure do |config|
    #     config.default_renderer = SomeRendererClass
    #   end
    #
    # Returns nothing.
    def configure
      yield self
    end

    # Internal: Sets the request environment.
    #
    # If the :breadcrumb key is not present in the environment, it will be set
    # to a new instance of Breadcrumb.
    #
    # Returns nothing.
    def request_env=(environment)
      @request_env = environment
    end

    # Internal: Gets the request environment.
    #
    # Returns a Hash containing the request environment.
    def request_env
      @request_env if defined?(@request_env)
    end


    # Internal: Sets the session
    #
    # If the :breadcrumb key is not present in the session, it will be set
    # to a new instance of Breadcrumb.
    #
    # Returns nothing.
    def session=(session)
      @session = session
    end

    # Internal: Gets the user session hash
    #
    # Returns the session object
    def session
      @session if defined?(@session)
    end


    # Internal: Gets the request id.
    #
    # Returns the current request id.
    def request
      @request_id if defined? @request_id
    end

    # Internal: Sets the request id.
    #
    # request_id - The request id.
    #
    # Returns nothing.
    def request=(request_id)
      @request_id = request_id
    end

    # Internal: Gets the Breadcrumb.
    #
    # Returns a Breadcrumb.
    def breadcrumb
      if @use_session_stack
        @session[:breadcrumb] ||= BreadcrumbStack.new 
      else
        @request_env[:breadcrumb] ||= Breadcrumb.new 
      end
    end

    # Internal: Sets the Breadcrumb.
    #
    # Returns nothing.
    def breadcrumb=(breadcrumb)
      if @use_session_stack
        @session[:breadcrumb] = breadcrumb
      else
        @request_env[:breadcrumb] = breadcrumb
      end
    end

    # Public: Returns the default renderer used by Ariane.
    #
    # If the default renderer hasn't been set yeat, it will be set
    # as a new Ariane::Render::HTMLList instance.
    #
    # Examples
    #
    #   Ariane.default_renderer
    #   # => #<Ariane::Render::HTMLList ...>
    #
    # Returns the default renderer.
    def default_renderer
      @default_renderer ||= Ariane::Render::HTMLList.new
    end

    # Public: Sets the default renderer used by Ariane.
    #
    # renderer - An instance or a class that will be used as default renderer
    #            by Ariane. If a class is given the default renderer will be set
    #            to a new instance of this class.
    #
    # Examples
    #
    #   Ariane.default_renderer = SomeRendererClass.new
    #
    #   Ariane.default_renderer = SomeRendererClass
    #   Ariane.default_renderer
    #   # => #<SomeRendererClass ...>
    #
    # Returns the default renderer.
    def default_renderer=(renderer)
      @default_renderer = renderer.is_a?(Class) ? renderer.new : renderer
    end

    # Public: Returns session stack setting
    #
    # Determines whether Ariane will use the default stateless breadcrumb,
    # or the session based breadcrumbstack.
    #
    # Returns the current or default option.
    def use_session_stack
      if defined? @use_session_stack
       return @user_session_stack 
      else
        return false
      end
    end

    # Public: Returns session stack setting
    #
    # Determines whether Ariane will use the default stateless breadcrumb,
    # or the session based breadcrumbstack.
    #
    # Examples
    #
    #   Ariane.configure do |config|
    #       config.use_session_stack = true
    #   end
    #
    # Returns the current option
    def use_session_stack=(option)
      @use_session_stack = option
    end
  end
end
