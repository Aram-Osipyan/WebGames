class WordleGame < ApplicationRecord
  belongs_to :day_word
  belongs_to :user
end
