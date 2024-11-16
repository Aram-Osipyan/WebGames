class UserResource < Avo::BaseResource
    self.title = :display_name
    self.description = -> { "Количество пользователей: #{User.count}" }
    self.includes = []
  
    field :id, as: :id
    field :external_id, as: :text
    field :created_at, as: :date_time, sortable: true, hide_on: [:forms]
  end
  