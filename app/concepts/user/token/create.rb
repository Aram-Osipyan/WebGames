class User
  module Token
    class Create < ApplicationService
      option :params

      def perform
        contract = Contract::Create.new
        contract_result = contract.call(params)

        return [:bad_request, { errors: contract_result.errors.to_h }] unless contract_result.success?

        user = User.find_or_create_by(external_id: contract_result[:external_id], game: contract_result[:game])

        active = AuthenticationLine.get_active(user.id)

        [:ok, { token: active.code }]
      end
    end
  end
end
