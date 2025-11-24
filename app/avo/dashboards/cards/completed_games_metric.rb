class Cards::CompletedGamesMetric < Avo::Dashboards::MetricCard
  self.id = 'completed_games_metric'
  self.label = 'Завершённых игр'
  self.description = 'Завершённые игры за последние 7 дней'
  self.cols = 1

  def query
    count = QuizGame.where('created_at > ? AND completed = ?', 7.days.ago, true).count

    result count
  end
end
