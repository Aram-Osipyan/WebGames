# frozen_string_literal: true

module Wordle
  module Stats
    # doc
    class Show
      def self.perform(current_user)
        current_user.last_rewarded_at ||= Time.at(0)
        current_game = ::WordleGame.where(user_id: current_user.id).where('active_until > ?', Time.current).first

        wordle_games = ::WordleGame
                       .joins(:day_word)
                       .joins(:user)
                       .where('wordle_games.created_at > :ago_days', ago_days: 5.days.ago.beginning_of_day)
                       .where(user_id: current_user.id)
                       .order('wordle_games.active_until')
                       .map do |game|
          word = nil
          word = game.day_word.word if game.game_state&.fetch('result') == 'win'

          result = game.game_state&.fetch('result') || 'lose'
          result = 'lose' if result == 'pending' && Time.current > game.active_until
          {
            word:,
            result:,
            active_until: game.active_until
          }
        end

        stats = []
        last_day = wordle_games.first[:active_until]
        wordle_games.each do |game|
          current_day = game[:active_until]

          if (current_day - last_day) / 24.0 / 60.0 / 60.0 > 1
            stats.clear
            stats.push(game)
          elsif current_day < current_user.last_rewarded_at
            stats.clear
          elsif %w[win pending].include? game[:result]
            stats.push(game)
          else
            stats.clear
          end

          last_day = current_day
        end

        stats.clear if stats.count > 5

        day_before_win = 5 - stats.count

        day_before_win.times do
          stats.push({
                       word: nil,
                       result: 'empty'
                     })
        end

        can_get_price = stats.last[:result] == 'win'
        can_get_price &&= current_user.last_rewarded_at + 4.days < Time.current if current_user.last_rewarded_at

        { result: stats, day_before_win:,
          current_result: current_game&.game_state&.fetch('result') || 'pending', can_get_price: }
      end
    end
  end
end
