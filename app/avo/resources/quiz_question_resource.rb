class QuizQuestionResource < Avo::BaseResource
  self.title = :question_text
  self.includes = []
  self.description = -> { "Управление вопросами для викторины" }
  self.search_query = -> do
    QuizQuestion.where("question_text ILIKE ?", "%#{params[:q]}%")
  end

  field :id, as: :id
  field :question_text, as: :textarea, required: true
  field :option_a, as: :text, required: true, name: "Вариант A"
  field :option_b, as: :text, required: true, name: "Вариант B"
  field :option_c, as: :text, required: true, name: "Вариант C"
  field :option_d, as: :text, required: true, name: "Вариант D"
  field :correct_answer, as: :select, required: true, name: "Правильный ответ", options: {
    'A' => 'A',
    'B' => 'B', 
    'C' => 'C',
    'D' => 'D'
  }
  field :category, as: :text, name: "Категория"
  field :difficulty, as: :select, name: "Сложность", options: {
    1 => 'Легкий',
    2 => 'Средний',
    3 => 'Сложный'
  }
  field :active, as: :boolean, name: "Активен"
  field :active_from, as: :date_time, name: "Активен с"
  field :active_until, as: :date_time, name: "Активен до"
  field :created_at, as: :date_time, name: "Создан", hide_on: [:new, :edit]
  field :updated_at, as: :date_time, name: "Обновлен", hide_on: [:new, :edit]

  # Filters can be added later
  # filter :active, QuizQuestionActiveFilter
  # filter :category, QuizQuestionCategoryFilter
  # filter :difficulty, QuizQuestionDifficultyFilter
end