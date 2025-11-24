class Cards::NewGamesMetric < Avo::Dashboards::MetricCard
  self.id = 'new_games_metric'
  self.label = 'Новых игр'
  self.description = 'Игры, созданные за последние 7 дней'
  self.cols = 1

  def query
    count = QuizGame.where('created_at > ?', 7.days.ago).count

    result count
  end
end
