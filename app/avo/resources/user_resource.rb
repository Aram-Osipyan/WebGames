class UserResource < Avo::BaseResource
    self.title = :display_name
    self.includes = []
  
    field :id, as: :id
    field :created_at, as: :date_time, sortable: true, hide_on: [:forms]
  end
  