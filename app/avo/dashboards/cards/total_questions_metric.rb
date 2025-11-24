class Cards::TotalQuestionsMetric < Avo::Dashboards::MetricCard
  self.id = 'total_questions_metric'
  self.label = 'Всего вопросов'
  self.description = 'Общее количество вопросов в системе'
  self.cols = 1

  def query
    total_count = QuizQuestion.count
    QuizQuestion.active.count

    result total_count
  end
end
