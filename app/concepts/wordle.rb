module Wordle
  def self.default_game_state
    {
      field: [],
      start_time: Time.current,
      result: 'pending'
    }
  end
end
