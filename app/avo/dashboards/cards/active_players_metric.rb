class Cards::ActivePlayersMetric < Avo::Dashboards::MetricCard
  self.id = 'active_players_metric'
  self.label = 'Активных игроков'
  self.description = 'Игроки, играющие в последние 7 дней'
  self.cols = 1

  def query
    count = User.joins(:quiz_games)
                .where('quiz_games.created_at > ?', 7.days.ago)
                .distinct
                .count

    result count
  end
end
