require_relative 'cards/total_questions_metric'
require_relative 'cards/total_games_metric'
require_relative 'cards/active_players_metric'
require_relative 'cards/new_games_metric'
require_relative 'cards/completed_games_metric'
require_relative 'cards/average_score_metric'

class QuizDashboard < Avo::Dashboards::BaseDashboard
  self.id = 'quiz_dashboard'
  self.description = 'Статистика и аналитика игр викторины'
  self.grid_cols = 3

  # Общая статистика
  card TotalQuestionsMetric
  card TotalGamesMetric
  card ActivePlayersMetric

  divider label: 'Статистика за последние 7 дней'

  card NewGamesMetric
  card CompletedGamesMetric
  card AverageScoreMetric

  divider label: 'Популярные категории'

  # Динамические карточки для категорий
  QuizQuestion.joins(:quiz_user_answers)
              .where('quiz_user_answers.created_at > ?', 7.days.ago)
              .group(:category)
              .count
              .each do |category, count|
    card category, number: count, description: 'ответов за неделю'
  end
end
