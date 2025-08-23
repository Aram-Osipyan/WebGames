# frozen_string_literal: true

require 'dry/validation'

module Quiz
  class CreateAnswerContract < Dry::Validation::Contract
    params do
      required(:answer).filled(:string)
      required(:question_id).filled(:integer)
      optional(:time_taken).maybe(:integer)
      optional(:hint_used).maybe(:boolean)
    end

    rule(:answer) do
      key.failure('must be A, B, C, or D') unless %w[A B C D].include?(value&.upcase)
    end

    rule(:question_id) do
      key.failure('must be a positive integer') if value && value <= 0
    end

    rule(:time_taken) do
      key.failure('must be a non-negative integer') if value && value < 0
    end
  end
end