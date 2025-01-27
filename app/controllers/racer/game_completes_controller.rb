# frozen_string_literal: true

module Racer
  class GameCompletesController < BaseController
    def create
      score = params[:score]
      return render json: { result_code: :error }, status: :unprocessable_entity unless score


      game = RacerGame.create!(user: current_user, score:)

      render json: game
    end
  end
end
