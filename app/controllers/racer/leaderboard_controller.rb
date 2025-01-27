# frozen_string_literal: true

module Racer
  class LeaderboardController < BaseController
    def index
      leaderboard = RacerGame
        .group(:user_id)
        .joins(:user)
        .select('MAX(score) max_score, MAX(users.external_id) name')
        .order(:max_score)
        .limit(10)
    
      render json: { data: leaderboard }
    end
  end
end
  