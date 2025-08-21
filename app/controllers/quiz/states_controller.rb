# frozen_string_literal: true

module Quiz
  class StatesController < BaseController
    def show
      result = Quiz::State::Show.perform(current_user, params)
      render json: result
    end

    def create
      return render json: { error: 'answer must be provided' }, status: :bad_request unless params.key?(:answer)
      return render json: { error: 'question_id must be provided' }, status: :bad_request unless params.key?(:question_id)

      answer = params[:answer].upcase
      question_id = params[:question_id].to_i
      time_taken = params[:time_taken]&.to_i || 0
      hint_used = params[:hint_used] == 'true'

      return render json: { error: 'invalid answer' }, status: :bad_request unless %w[A B C D].include?(answer)

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
  end
end