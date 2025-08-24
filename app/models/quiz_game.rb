class QuizGame < ApplicationRecord
  belongs_to :user
  has_many :quiz_user_answers, dependent: :destroy
  has_many :quiz_questions, through: :quiz_user_answers

  validates :total_questions, presence: true, numericality: { greater_than: 0 }
  validates :score, numericality: { greater_than_or_equal_to: 0 }
  validates :correct_answers, numericality: { greater_than_or_equal_to: 0 }

  scope :completed, -> { where(completed: true) }
  scope :active, -> { where(completed: false).where('active_until > ?', Time.current) }
  scope :for_today, -> { where('created_at >= ?', Time.current.beginning_of_day) }

  def self.current_game_for_user(user)
    where(user: user)
      .where('active_until > ?', Time.current)
      .where(completed: false)
      .first
  end

  def self.create_daily_game(user)
    return current_game_for_user(user) if current_game_for_user(user)

    questions = QuizQuestion.daily_questions(10)

    create!(
      user: user,
      active_until: Time.current.end_of_day,
      total_questions: 10,
      game_state: {
        questions: questions.map(&:id),
        current_question: 0,
        hints_used: 0,
        start_time: Time.current.to_i
      }
    )
  end

  def current_question
    return nil if completed? || current_question_index >= total_questions

    question_ids = game_state['questions'] || []
    QuizQuestion.find(question_ids[current_question_index]) if question_ids[current_question_index]
  end

  def current_answer
    QuizGame.current_game_for_user(user).quiz_user_answers.where(quiz_question: current_question).last
  end

  def current_question_index
    game_state['current_question'] || 0
  end

  def next_question!
    self.game_state = game_state.merge('current_question' => current_question_index + 1)
    save!
  end

  def correct?
    quiz_user_answers.find_by(quiz_question: current_question).is_correct
  end

  def answer_question!(question, selected_answer, time_taken = 0, hint_used = false)
    is_correct = question.correct_answer == selected_answer.upcase

    quiz_user_answers.create!(
      quiz_question: question,
      selected_answer: selected_answer.upcase,
      is_correct: is_correct,
      time_taken: time_taken,
      hint_used: hint_used
    )

    if is_correct
      self.correct_answers += 1
      self.score += hint_used ? 50 : 100 # Less points if hint was used
    end

    # next_question!

    complete_game! if current_question_index >= total_questions

    save!
    is_correct
  end

  def complete_game!
    self.completed = true
    self.completed_at = Time.current
    save!
  end

  def progress_percentage
    return 100 if completed?

    (current_question_index.to_f / total_questions * 100).round
  end

  def remaining_questions
    total_questions - current_question_index
  end

  def hints_used_count
    game_state['hints_used'] || 0
  end

  def use_hint!
    self.game_state = game_state.merge('hints_used' => hints_used_count + 1)
    save!
  end
end
