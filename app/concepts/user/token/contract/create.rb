class User
  module Token
    module Contract
      class Create < Dry::Validation::Contract
        params do
          required(:game).filled(:string)
          optional(:external_id).maybe(:string)
        end

        rule do
          values[:game] ||= 'wordle'
        end
      end
    end
  end
end
