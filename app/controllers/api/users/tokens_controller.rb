module Api
  module Users
    class TokensController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        unless params.key?(:external_id)
          return render json: { error: 'external_id must be filled' }, status: :bad_request
        end

        user = User.find_by(external_id: params[:external_id])
        user ||= User.create!(external_id: params[:external_id])

        active = AuthenticationLine.get_active(user.id)

        render json: { token: active.code }
      end
    end
  end
end
