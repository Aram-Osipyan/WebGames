# frozen_string_literal: true

module Quiz
  class StatsController < BaseController
    def show
      result = Quiz::Stats::Show.perform(current_user)
      render json: result
    end
  end
end