# frozen_string_literal: true

module Quiz
  class StatesController < BaseController
    def show
      result = Quiz::State::Show.perform(current_user, params)
      render json: result
    end

    def create
      contract = Quiz::CreateAnswerContract.new
      result = contract.call(params.permit(:answer, :question_id, :time_taken, :hint_used))

      if result.failure?
        errors = result.errors.to_h
        return render json: { error: format_validation_errors(errors) }, status: :bad_request
      end

      validated_params = result.to_h
      answer = validated_params[:answer].upcase
      question_id = validated_params[:question_id]
      time_taken = validated_params[:time_taken] || 0
      hint_used = validated_params[:hint_used] == 'true'

      current_game = QuizGame.current_game_for_user(current_user)
      current_game ||= QuizGame.create_daily_game(current_user)

      question = QuizQuestion.find_by(id: question_id)
      return render json: { error: 'question not found' }, status: :not_found unless question

      # Check if question is already answered
      existing_answer = current_game.quiz_user_answers.find_by(quiz_question: question)
      return render json: { error: 'question already answered' }, status: :bad_request if existing_answer

      # Check if this is the current question
      return render json: { error: 'not current question' }, status: :bad_request unless current_game.current_question&.id == question_id

      if hint_used
        current_game.use_hint!
      end

      is_correct = current_game.answer_question!(question, answer, time_taken, hint_used)

      result = {
        is_correct: is_correct,
        correct_answer: question.correct_answer,
        correct_option: question.correct_option_text,
        score: current_game.score,
        progress: current_game.progress_percentage,
        completed: current_game.completed?
      }

      if current_game.completed?
        result[:final_score] = current_game.score
        result[:correct_answers] = current_game.correct_answers
        result[:total_questions] = current_game.total_questions
      end

      render json: result
    end

    private

    def format_validation_errors(errors)
      errors.map { |key, messages| "#{key}: #{Array(messages).join(', ')}" }.join('; ')
    end
  end
end