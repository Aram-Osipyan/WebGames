# frozen_string_literal: true

module Quiz
  module State
    # doc
    class Show
      def self.perform(current_user, params)
        current_game = QuizGame.current_game_for_user(current_user)
        current_game ||= QuizGame.create_daily_game(current_user)

        current_question = current_game.current_question
        
        result = {
          game_id: current_game.id,
          score: current_game.score,
          correct_answers: current_game.correct_answers,
          total_questions: current_game.total_questions,
          current_question_index: current_game.current_question_index,
          progress: current_game.progress_percentage,
          completed: current_game.completed?,
          hints_used: current_game.hints_used_count,
          remaining_questions: current_game.remaining_questions
        }

        if current_question && !current_game.completed?
          result[:current_question] = {
            id: current_question.id,
            question_text: current_question.question_text,
            options: current_question.options,
            category: current_question.category,
            difficulty: current_question.difficulty
          }
        end

        if current_game.completed?
          result[:final_score] = current_game.score
          result[:completed_at] = current_game.completed_at
        end

        result
      end
    end
  end
end