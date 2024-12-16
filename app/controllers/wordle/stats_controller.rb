# frozen_string_literal: true

module Wordle
  class StatsController < BaseController
    def show
      current_game = ::WordleGame.where(user_id: current_user.id).where('active_until > ?', Time.current).first


      wordle_games = ::WordleGame
        .where('wordle_games.created_at > :ago_days', ago_days: 5.days.ago.beginning_of_day)
        .joins(:day_word)
        .where(user_id: current_user.id)
        .order('wordle_games.active_until')
        .map do |game|
          word = nil
          word = game.day_word.word if game.game_state&.fetch('result') == 'win'

          result = game.game_state&.fetch('result') || 'lose'
          result = 'lose' if result == 'pending' && Time.current > game.active_until
          {
            word:,
            result: 
          }
        end
      pp wordle_games
      
      stats = []
      wordle_games.each do |game|
        case game[:result]
        when 'win', 'pending'
          stats.push(game)
        else
          stats.clear
        end
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

      render json: { result: stats, day_before_win:, current_result: current_game&.game_state&.fetch('result') || 'pending', can_get_price:}
    end
  end
end
