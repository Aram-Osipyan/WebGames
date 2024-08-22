# frozen_string_literal: true

module Middleware
  class GameAuthentication
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)

      p request.original_fullpath
      path = request.original_fullpath.split('/')

      return @app.call(env) if path[1] != 'games'

      token = path[2]
      line = AuthenticationLine.where(code: token, active: true).where('active_until > ?', Time.current)

      return [Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request], {}, []] if line.empty?

      # request.query_parameters.key?('hello_world')
      @app.call(env)
    end
  end
end
