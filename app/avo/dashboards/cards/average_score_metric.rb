class Cards::AverageScoreMetric < Avo::Dashboards::MetricCard
  self.id = 'average_score_metric'
  self.label = 'Средний балл'
  self.description = 'Средний балл завершённых игр за 7 дней'
  self.cols = 1

  def query
    average = QuizGame.where('created_at > ? AND completed = ?', 7.days.ago, true)
                      .average(:score)&.round || 0

    result average
  end
end
