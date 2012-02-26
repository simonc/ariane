require 'ariane/version'
require 'ariane/crumb'
require 'ariane/breadcrumb'
require 'ariane/render'

require 'ariane/rails' if defined?(Rails)

module Ariane
  class << self
    attr_accessor :request

    def configure
      yield self
    end

    def request_env=(environment)
      @request_env = environment
      @request_env[:breadcrumb] ||= Breadcrumb.new
    end

    def request_env
      @request_env if defined?(@request_env)
    end

    def request
      @request_id if defined? @request_id
    end

    def request=(request_id)
      @request_id = request_id
    end

    def breadcrumb
      @request_env[:breadcrumb]
    end

    def breadcrumb=(breadcrumb)
      @request_env[:breadcrumb] = breadcrumb
    end

    def default_renderer
      @default_renderer ||= Ariane::Render::HTMLList.new
    end

    def default_renderer=(renderer)
      @default_renderer = renderer.is_a?(Class) ? renderer.new : renderer
    end
  end
end
