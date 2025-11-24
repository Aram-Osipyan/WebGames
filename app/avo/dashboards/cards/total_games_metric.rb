class Cards::TotalGamesMetric < Avo::Dashboards::MetricCard
  self.id = 'total_games_metric'
  self.label = 'Всего игр'
  self.description = 'Общее количество игр в системе'
  self.cols = 1

  def query
    total_count = QuizGame.count

    result total_count
  end
end
