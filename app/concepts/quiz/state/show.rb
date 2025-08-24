# frozen_string_literal: true

module Quiz
  module State
    class Show
      def self.perform(current_user, params)
        current_game = QuizGame.current_game_for_user(current_user)
        current_game ||= QuizGame.create_daily_game(current_user)

        Quiz::Representer::GameState.new(current_game)
      end
    end
  end
end