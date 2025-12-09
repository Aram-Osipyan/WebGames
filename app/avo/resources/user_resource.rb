class UserResource < Avo::BaseResource
  self.title = :external_id
  self.includes = []

  field :id, as: :id
  field :external_id, as: :text
  field :game, as: :select, name: 'Игра', options: {
    'quiz' => 'Quiz',
    'wordle' => 'Wordle',
    'racer' => 'Racer'
  }
  field :created_at, as: :date_time, sortable: true, hide_on: [:forms]
end
