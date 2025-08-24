# frozen_string_literal: true

module Quiz
  module Stats
    # doc
    class Show
      def self.perform(current_user)
        current_user.last_rewarded_at ||= Time.at(0)
        current_game = QuizGame.current_game_for_user(current_user)

        # Get recent quiz games (last 7 days)
        quiz_games = QuizGame
          .where(user_id: current_user.id)
          .where('created_at > ?', 7.days.ago.beginning_of_day)
          .order(:created_at)
          .map do |game|
            result = if game.completed?
              game.correct_answers >= 7 ? 'win' : 'lose'
            elsif Time.current > game.active_until
              'lose'
            else
              'pending'
            end

            {
              score: game.score,
              correct_answers: game.correct_answers,
              total_questions: game.total_questions,
              result: result,
              completed_at: game.completed_at,
              active_until: game.active_until
            }
          end

        # Calculate streak
        streak = 0
        quiz_games.reverse.each do |game|
          break unless game[:result] == 'win'
          streak += 1
        end

        # Calculate statistics
        total_games = quiz_games.count
        won_games = quiz_games.count { |g| g[:result] == 'win' }
        win_rate = total_games > 0 ? (won_games.to_f / total_games * 100).round : 0
        
        average_score = if total_games > 0
          (quiz_games.sum { |g| g[:score] }.to_f / total_games).round
        else
          0
        end

        best_score = quiz_games.map { |g| g[:score] }.max || 0

        # Check if user can get reward (won today and hasn't been rewarded in last 24 hours)
        today_game = quiz_games.find { |g| g[:active_until] >= Time.current.beginning_of_day }
        can_get_price = today_game&.dig(:result) == 'win'
        can_get_price &&= current_user.last_rewarded_at + 1.day < Time.current if current_user.last_rewarded_at

        {
          current_result: current_game&.completed? ? (current_game.correct_answers >= 7 ? 'win' : 'lose') : 'pending',
          streak: streak,
          total_games: total_games,
          won_games: won_games,
          win_rate: win_rate,
          average_score: average_score,
          best_score: best_score,
          recent_games: quiz_games.last(5),
          can_get_price: can_get_price
        }
      end
    end
  end
end