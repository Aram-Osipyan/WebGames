# frozen_string_literal: true

require 'dry/validation'

module Quiz
  class NextQuestionContract < Dry::Validation::Contract
    option :current_game

    params {}

    rule do
      key.failure('current question not yet answered') unless current_game.current_answer
    end
  end
end
