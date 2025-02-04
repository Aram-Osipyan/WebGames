# frozen_string_literal: true

module Wordle
  class PricesController < BaseController
    def show
      result = ::Wordle::Stats::Show.perform(current_user)

      if result[:can_get_price]
        connection = Faraday.new(url: 'http://62.182.8.15:8800') do |conn|
          conn.response :json
        end

        formatted_id = current_user.external_id[-7..-1]
  
        path = "/award_prize?msisdn=#{formatted_id}&prize=1"
  
        response = connection.get(path)

        current_user.update!(last_rewarded_at: Time.current)
        result[:can_get_price] = false
      end

      render json: result
    end
  end
end
