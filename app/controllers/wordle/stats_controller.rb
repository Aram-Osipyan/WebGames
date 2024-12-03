# frozen_string_literal: true

module Wordle
  class StatsController < BaseController
    def show
      days = %w[MON TUE WED THU FRI SAT SUN]
      sql = "VALUES #{days.each_with_index.map { |value, index| "(#{index + 1}, '#{value}')" }.join(', ')}"

      games_sql =
        ::WordleGame
        .select('To_Char("wordle_games"."created_at", \'DY\') as week_day, game_state, day_words.word as day_word')
        .joins(:day_word)
        .where(user_id: current_user.id)
        .where('wordle_games.created_at >= ?', Time.current.beginning_of_week)
        .to_sql

      result = ActiveRecord::Base.connection.execute("
        select
          t.i index,
          t.day,
          (games.game_state ->> 'result')::TEXT result,
          case when (games.game_state ->> 'result')::TEXT = 'win' then games.day_word end as word
        from (#{sql}) as t (i, day)
        left join (#{games_sql}) as games on t.day = games.week_day").to_a

      wday_index = Time.current.wday
      result.each do |res|
        res['result'] ||= 'lose' if res['index'] < wday_index 
      end

      current_game = ::WordleGame.where(user_id: current_user.id).where('active_until > ?', Time.current).first

      render json: { result:, day_before_win: [(Time.current.end_of_week.day - Time.current.day) - 2, 0].max, current_result: current_game.game_state['result'] }
    end
  end
end
