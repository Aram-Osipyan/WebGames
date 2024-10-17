module Wordle
  module Representer
    class GameState
      include Alba::Resource

      attributes :start_time
      many :field do
        attributes :word
        attributes :state
      end
    end
  end
end
