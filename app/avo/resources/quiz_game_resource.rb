class QuizGameResource < Avo::BaseResource
  self.title = :id
  self.includes = [:user]
  self.description = -> { 'Управление играми викторины' }
  self.search_query = lambda {
    QuizGame.joins(:user).where('users.external_id ILIKE ?', "%#{params[:q]}%")
  }

  self.visible_on_sidebar = lambda {
    current_user.game == 'quiz'
  }

  field :id, as: :id
  field :user, as: :belongs_to, name: 'Пользователь'
  field :score, as: :number, name: 'Очки'
  field :correct_answers, as: :number, name: 'Правильных ответов'
  field :total_questions, as: :number, name: 'Всего вопросов'
  field :completed, as: :boolean, name: 'Завершена'
  field :completed_at, as: :date_time, name: 'Завершена в'
  field :active_until, as: :date_time, name: 'Активна до'
  field :game_state, as: :code, language: :json, name: 'Состояние игры', hide_on: [:index]
  field :created_at, as: :date_time, name: 'Создана'
  field :updated_at, as: :date_time, name: 'Обновлена'

  field :quiz_user_answers, as: :has_many, name: 'Ответы пользователя'

  # Filters can be added later
  # filter :completed, QuizGameCompletedFilter
  # filter :created_at, QuizGameDateFilter
end
