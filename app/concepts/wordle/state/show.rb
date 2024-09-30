# frozen_string_literal: true

module Wordle
  module State
    # doc
    class Show
      def self.perform(current_user, params)
        current_game = ::WordleGame.where(user_id: current_user.id).where('active_until > ?', Time.current).first

        current_day_word = DayWord.find_by(active: true)
        current_game ||= ::WordleGame.create!(
          user_id: current_user.id,
          active_until: Time.current.end_of_day,
          day_word_id: current_day_word.id
        )

        current_game.update!(game_state: { field: [], start_time: Time.current }) if current_game.game_state.blank?
        render json: { game_state: current_game.game_state || [] }
      end
    end
  end
end
