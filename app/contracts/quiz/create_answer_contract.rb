# frozen_string_literal: true

require 'dry/validation'

module Quiz
  class CreateAnswerContract < Dry::Validation::Contract
    option :current_game

    params do
      required(:answer).filled(included_in?: %w[A B C D])
      required(:question_id).filled(:integer)
      optional(:time_taken).maybe(:integer, gteq?: 0)
      optional(:hint_used).maybe(:bool)
    end

    rule(:question_id) do |context:|
      context[:question] = question = QuizQuestion.find_by(id: value)

      key.failure('question not found') unless question
      key.failure('question already answered') if current_game.quiz_user_answers.find_by(quiz_question: question)
      key.failure('not current question') unless current_game.current_question&.id == value
    end
  end
end
