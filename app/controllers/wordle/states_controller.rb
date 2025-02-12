# frozen_string_literal: true

module Wordle
  class StatesController < BaseController
    def show
      result = Wordle::State::Show.perform(current_user, params)

      render json: result
    end

    def create  
      return render json: { error: 'word must be filled' }, status: :bad_request unless params.key?(:word)

      word = params[:word].downcase
      result = Word::Validate.valid?(word)

      return render json: { error: 'invalid word' }, status: 410 unless result

      current_game = ::WordleGame.where(user_id: current_user.id).where('active_until > ?', Time.current).first
      current_day_word = DayWord.current_day_word

      current_game ||= ::WordleGame.create!(
        user_id: current_user.id,
        active_until: Time.current.end_of_day,
        day_word_id: current_day_word.id,
        analyze_data: Wordle.default_game_state
      )

      game_state = current_game.game_state || Wordle.default_game_state

      if %w[win lose].exclude?(game_state['result']) && game_state['field'].size < 6
        state = Word::Validate.state(word, current_day_word.word)

        game_state['field'] ||= []
        game_state['field'] << { state:, word: }

        result =
          if state.all? { |el| el == 3 }
            'win'
          elsif game_state['field'].size == 6
            'lose'
          else
            'pending'
          end

        game_state['result'] = result

        current_game.update!(game_state:)
      end

      render json: { game_state: current_game.game_state || [] }
    end
  end
end
