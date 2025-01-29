# frozen_string_literal: true

module Wordle
  class PricesController < BaseController
    def show
      result = ::Wordle::Stats::Show.perform(current_user)

      if result[:can_get_price]
        connection = Faraday.new(url: 'http://62.182.8.15:8800') do |conn|
          conn.response :json
        end
  
        path = "/award_prize?msisdn=#{current_user.external_id}&prize=1"
  
        response = connection.get(path)

        current_user.update!(last_rewarded_at: Time.current)
        result[:can_get_price] = false
      end

      render json: result
    end
  end
end
