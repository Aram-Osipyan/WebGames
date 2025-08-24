class QuizQuestion < ApplicationRecord
  has_many :quiz_user_answers, dependent: :destroy
  has_many :quiz_games, through: :quiz_user_answers

  validates :question_text, presence: true
  validates :option_a, :option_b, :option_c, :option_d, presence: true
  validates :correct_answer, inclusion: { in: %w[A B C D] }
  validates :difficulty, inclusion: { in: [1, 2, 3] }

  scope :active, -> { where(active: true) }
  scope :by_difficulty, ->(level) { where(difficulty: level) }
  scope :by_category, ->(category) { where(category: category) }
  scope :available_for_date, ->(date) do
    where('active_from <= ? AND (active_until IS NULL OR active_until >= ?)', date, date)
  end

  def self.daily_questions(limit = 10)
    active.available_for_date(Time.current).order('RANDOM()').limit(limit)
  end

  def options
    {
      'A' => option_a,
      'B' => option_b,
      'C' => option_c,
      'D' => option_d
    }
  end

  def correct_option_text
    options[correct_answer]
  end
end