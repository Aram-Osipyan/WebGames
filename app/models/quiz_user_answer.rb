class QuizUserAnswer < ApplicationRecord
  belongs_to :quiz_game
  belongs_to :quiz_question

  validates :selected_answer, inclusion: { in: %w[A B C D] }
  validates :time_taken, numericality: { greater_than_or_equal_to: 0 }

  scope :correct, -> { where(is_correct: true) }
  scope :incorrect, -> { where(is_correct: false) }
  scope :with_hint, -> { where(hint_used: true) }
  scope :without_hint, -> { where(hint_used: false) }

  def selected_option_text
    quiz_question.options[selected_answer]
  end

  def correct_option_text
    quiz_question.correct_option_text
  end
end