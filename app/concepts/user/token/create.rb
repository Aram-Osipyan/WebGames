class User
  module Token
    class Create < ApplicationService
      option :params

      def perform
        contract = Contract::Create.new
        contract_result = contract.call(params)

        return render json: { errors: contract_result.errors.to_h }, status: :bad_request unless contract.success?

        user = User.find_or_create_by(external_id: contract_result[:external_id], game: contract_result[:game])

        active = AuthenticationLine.get_active(user.id)

        { token: active.code }
      end
    end
  end
end
