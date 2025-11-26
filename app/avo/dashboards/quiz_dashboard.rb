require_relative 'cards/total_questions_metric'
require_relative 'cards/total_games_metric'
require_relative 'cards/active_players_metric'
require_relative 'cards/new_games_metric'
require_relative 'cards/completed_games_metric'
require_relative 'cards/average_score_metric'

class QuizDashboard < Avo::Dashboards::BaseDashboard
  self.id = 'quiz_dashboard'
  self.name = 'Аналитика Викторины'
  self.description = 'Статистика и аналитика игр викторины'
  self.grid_cols = 3

  # Общая статистика
  card Cards::TotalQuestionsMetric
  card Cards::TotalGamesMetric
  card Cards::ActivePlayersMetric

  divider label: 'Статистика за последние 7 дней'

  card Cards::NewGamesMetric
  card Cards::CompletedGamesMetric
  card Cards::AverageScoreMetric

  divider label: 'Популярные категории'

  # Динамические карточки для категорий
  # QuizQuestion.joins(:quiz_user_answers)
  #             .where('quiz_user_answers.created_at > ?', 7.days.ago)
  #             .group(:category)
  #             .count
  #             .each do |category, count|
  #   card category, number: count, description: 'ответов за неделю'
  # end
end
