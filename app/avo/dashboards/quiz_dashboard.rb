class QuizDashboard < Avo::Dashboards::BaseDashboard
  self.id = "quiz_dashboard"
  self.name = "Аналитика Викторины"
  self.description = "Статистика и аналитика игр викторины"
  self.grid_cols = 3

  def cards
    card "Всего вопросов", number: QuizQuestion.count, description: "Активных: #{QuizQuestion.active.count}"
    card "Всего игр", number: QuizGame.count, description: "Завершённых: #{QuizGame.completed.count}"
    card "Активных игроков", number: User.joins(:quiz_games).where('quiz_games.created_at > ?', 7.days.ago).distinct.count

    divider label: "Статистика за последние 7 дней"

    card "Новых игр", number: QuizGame.where('created_at > ?', 7.days.ago).count
    card "Завершённых игр", number: QuizGame.where('created_at > ? AND completed = ?', 7.days.ago, true).count
    card "Средний балл", number: QuizGame.where('created_at > ? AND completed = ?', 7.days.ago, true).average(:score)&.round || 0

    divider label: "Популярные категории"

    QuizQuestion.joins(:quiz_user_answers)
                .where('quiz_user_answers.created_at > ?', 7.days.ago)
                .group(:category)
                .count
                .each do |category, count|
      card category, number: count, description: "ответов за неделю"
    end
  end
end