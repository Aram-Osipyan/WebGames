# frozen_string_literal: true

module Wordle
  class StatsController < BaseController
    def show
      result = ::Wordle::Stats::Show.perform(current_user)

      render json: result
    end
  end
end
