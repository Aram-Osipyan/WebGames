class User
  module Token
    module Contract
      class Create < Dry::Validation::Contract
        params do
          required(:external_id).filled(:string)
          optional(:game).maybe(:string)
        end

        rule do
          values[:game] ||= 'wordle'
        end
      end
    end
  end
end
