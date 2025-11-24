class User < ApplicationRecord
  has_many :quiz_games, dependent: :destroy
end
