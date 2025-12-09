module Api
  module Users
    class TokensController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        status, body = User::Token::Create.perform(params: params.to_unsafe_h)
        render json: body, status: status
      end
    end
  end
end
