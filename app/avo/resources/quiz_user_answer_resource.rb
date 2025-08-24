class QuizUserAnswerResource < Avo::BaseResource
  self.title = :id
  self.includes = [:quiz_game, :quiz_question]
  self.description = -> { "Ответы пользователей на вопросы викторины" }

  field :id, as: :id
  field :quiz_game, as: :belongs_to, name: "Игра"
  field :quiz_question, as: :belongs_to, name: "Вопрос"
  field :selected_answer, as: :select, name: "Выбранный ответ", options: {
    'A' => 'A',
    'B' => 'B',
    'C' => 'C', 
    'D' => 'D'
  }
  field :is_correct, as: :boolean, name: "Правильный ответ"
  field :time_taken, as: :number, name: "Время (сек)"
  field :hint_used, as: :boolean, name: "Использована подсказка"
  field :created_at, as: :date_time, name: "Создан"

  # Filters can be added later
  # filter :is_correct, QuizUserAnswerCorrectFilter
  # filter :hint_used, QuizUserAnswerHintFilter
end