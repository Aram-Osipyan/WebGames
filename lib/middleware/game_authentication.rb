module Middleware
  class GameAuthentication
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)

      p request.original_fullpath
      if request.original_fullpath.include?('25') #request.query_parameters.key?('hello_world')
        @app.call(env)
      else
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:too_many_requests]

        [status_code, {}, []]
      end
    end
  end
end
