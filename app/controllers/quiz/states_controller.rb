# frozen_string_literal: true

module Quiz
  class StatesController < BaseController
    def show
      result = Quiz::State::Show.perform(current_user, params)
      render json: result
    end

    def create
      current_game = QuizGame.current_game_for_user(current_user)
      current_game ||= QuizGame.create_daily_game(current_user)

      contract = Quiz::CreateAnswerContract.new(current_game:)
      result = contract.call(params.to_unsafe_hash)

      if result.failure?
        errors = result.errors.to_h
        return render json: { error: format_validation_errors(errors) }, status: :bad_request
      end

      validated_params = result.to_h
      answer = validated_params[:answer].upcase
      time_taken = validated_params[:time_taken]
      hint_used = validated_params[:hint_used]

      question = result.context[:question]

      current_game.use_hint! if hint_used

      current_game.answer_question!(question, answer, time_taken, hint_used)

      render json: Quiz::Representer::GameState.new(current_game)
    end

    def next
      current_game = QuizGame.current_game_for_user(current_user)

      return render json: { error: 'game not found' }, status: :not_found unless current_game

      contract = Quiz::NextQuestionContract.new(current_game:)
      result = contract.call(params.to_unsafe_hash)

      if result.failure?
        errors = result.errors.to_h
        return render json: { error: format_validation_errors(errors) }, status: :bad_request
      end

      current_game.next_question!

      render json: Quiz::Representer::GameState.new(current_game)
    end

    private

    def format_validation_errors(errors)
      errors.map { |key, messages| "#{key}: #{Array(messages).join(', ')}" }.join('; ')
    end
  end
end
